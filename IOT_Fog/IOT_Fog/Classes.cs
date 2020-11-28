using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows;
using System.Windows.Media;

namespace IOT_Fog
{

    public class Registro
    {
        public DateTime getData()
        {
            return new DateTime(ano, mes, dia);
        }
        public SolidColorBrush cor { get; set; } = Brushes.Green;

        public int dia { get; set; } = DateTime.Now.Day;
        public int mes { get; set; } = DateTime.Now.Month;
        public int ano { get; set; } = DateTime.Now.Year;
        public string hora
        {
            get
            {
                return hora_dt.Hour.ToString().PadLeft(2,'0') + ":" + hora_dt.Minute.ToString().PadLeft(2, '0');
            }
        }
        public DateTime hora_dt { get; set; } = DateTime.Now;
        public double temperatura { get; set; } = 0;
        public int porta { get; set; } = 1;
        public Registro()
        {

        }
        public Registro(DB.Linha l)
        {
            this.ano = l.Get("ano").Int;
            this.mes = l.Get("mes").Int;
            this.dia = l.Get("dia").Int;
            this.hora_dt = l.Get("hora").Data;
            this.temperatura = l.Get("temperatura").Double();
            this.porta = l.Get("porta").Int;


            if(temperatura<=35)
            {
                //Hipotermia
                cor = Brushes.Blue.Clone();
            }
            else if(temperatura<=37.5)
            {
                //Normal
                cor = Brushes.Green.Clone();
            }
            else if (temperatura <= 39.5)
            {
                //Febre
                cor = Brushes.Orange.Clone();
            }
            else if (temperatura <= 41)
            {
                //Febre alta
                cor = Brushes.OrangeRed.Clone();
            }
            else 
            {
                //Hipertermia
                cor = Brushes.Red.Clone();
            }
            cor.Opacity = .3;
        }
    }

    public class Registros
    {
        public List<Registro> GetRegistros(DateTime de, DateTime ate)
        {
            List<Registro> registros = new List<Registro>();
            string comando = "select * from dlmdev.iot_log_temperaturas as pr " +
                $"where pr.ano >='{de.Year}' and pr.mes >='{de.Month}' and pr.dia >='{de.Day}'" +
                $" and pr.ano <='{ate.Year}' and pr.mes <='{ate.Month}' and pr.dia <='{ate.Day}'";

            //retorna a lista
            var consulta = banco.Consulta(comando);
            foreach(var s in consulta.Linhas)
            {
                Registro reg = new Registro(s);
                registros.Add(reg);
            }

            return registros.OrderByDescending(x=>x.getData()).ToList();
        }
        public DB.Banco banco { get; set; } = new DB.Banco("mysql.dlmdev.com.br","3306","dlmdev", "siLfDgDfLLyEc23", "dlmdev");
        public bool Gravar(string temperatura, int porta,bool mensagem = true)
        {
            //converte a temperatua em double
            var temp = ToDouble(temperatura, 2);
            if(temp<=0 | temp>50)
            {
                if(mensagem)
                {
                MessageBox.Show($"Temperatura Inválida: {temperatura} °C");
                }
                return false;
            }
            var reg = new Registro();

            //grava no banco de dados
            DB.Linha l = new DB.Linha();
            l.Add("temperatura", temperatura);
            l.Add("porta", porta);

            var gravou = banco.Cadastro(l.Celulas, "dlmdev", "iot_log_temperaturas");
            reg.temperatura = temp;
            reg.porta = porta;

           return gravou>0;
        }


        private  System.Globalization.CultureInfo US = new System.Globalization.CultureInfo("en-US");
        private  System.Globalization.CultureInfo BR = new System.Globalization.CultureInfo("pt-BR");
        public double ToDouble(object comp, int Decimais = 4)
        {
            if (comp == null)
            {
                return 0;
            }

            try
            {

                double val;
                if (double.TryParse(comp.ToString().Replace(" ", "").Replace("%", "").Replace("@", "").Replace("#", ""), System.Globalization.NumberStyles.Float, BR, out val))
                {
                    try
                    {
                        return Math.Round(val, Decimais);

                    }
                    catch (Exception)
                    {

                        return val;
                    }
                }

                else if (double.TryParse(comp.ToString().Replace(" ", "").Replace("%", "").Replace("@", "").Replace("#", ""), System.Globalization.NumberStyles.Float, US, out val))
                {
                    try
                    {

                        return Math.Round(val, Decimais);
                    }
                    catch (Exception)
                    {
                        return val;
                    }
                }
                else return 0;
            }
            catch (Exception)
            {

                return 0;
            }


        }
    }
}
