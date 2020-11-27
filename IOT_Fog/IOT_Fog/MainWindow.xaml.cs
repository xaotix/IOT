using FirstFloor.ModernUI.Windows.Controls;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
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
        public MainWindow()
        {
            InitializeComponent();
            GetRegistros();
        }
        public Registros Registros { get; set; } = new Registros();
        private void gravar_temperatura(object sender, RoutedEventArgs e)
        {
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
    }
}
