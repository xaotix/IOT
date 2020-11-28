using FirstFloor.ModernUI.Windows.Controls;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace IOT_Fog
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : ModernWindow
    {


        //porta serial que retorna os dados do arduino
        System.IO.Ports.SerialPort Port { get; set; }
        //booleano que grava se o arduino está conectado, para rodar o loop.
        bool IsClosed { get; set; } = false;

        private void ListenSerial()
        {
            while (!IsClosed)
            {
                try
                {
                    //lê informação que veio
                    string AString = Port.ReadLine();

                    //adiciona a leitura do Arduino na caixa de texto
                    arduino.AppendText($"\nRetorno do arduíno: {AString}");

                    //grava no banco de dados
                    if (Registros.Gravar(AString, 1,false))
                    {
                        GetRegistros();
                    }
                    //aguarda 2 segundos
                    Thread.Sleep(2000);
                }
                catch (Exception ex)
                {
                    //retorna o erro que o arduino passou
                    arduino.AppendText($"\nErro ao tentar ler Arduíno: {ex.Message}");
                }

            }
        }


        public MainWindow()
        {

            InitializeComponent();
            GetRegistros();


        }

        private void ConectarArduino()
        {

            try
            {
                arduino.AppendText("\nTentando conectar ao Arduíno na porta COM3...");
                //inicializa a porta
                Port = new System.IO.Ports.SerialPort();
                Port.PortName = "COM3";
                Port.BaudRate = 9600;
                Port.ReadTimeout = 500;
                Port.Open();

                //Inicializa a thread que fica escutando a porta
                Thread Tarefa = new Thread(ListenSerial);
                Tarefa.Start();
            }
            catch (Exception ex)
            {
                arduino.AppendText($"\n Não foi possível conectar... {ex.Message}");
            }
        }

        public Registros Registros { get; set; } = new Registros();
        private void gravar_temperatura(object sender, RoutedEventArgs e)
        {
            //adicionar uma temperatura para simular
            gravar();
        }

        private void gravar()
        {
            if (Registros.Gravar(temperatura.Text, 1))
            {
                GetRegistros();
            }
        }

        private void GetRegistros()
        {
            this.lista.ItemsSource = null;
            this.lista.ItemsSource = Registros.GetRegistros(DateTime.Now.AddMonths(-1), DateTime.Now.AddMonths(1));
        }

        private void temperatura_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Enter)
            {
                gravar();
            }
        }

        private void arduino_TextChanged(object sender, TextChangedEventArgs e)
        {

        }

        private void ModernWindow_Closing(object sender, System.ComponentModel.CancelEventArgs e)
        {
            //tenta fechar a conexao
            try
            {
                if (Port.IsOpen)
                    Port.Close();
            }
            catch (Exception)
            {

            }

        }

        private void ModernWindow_Loaded(object sender, RoutedEventArgs e)
        {
            ConectarArduino();
        }
    }
}
