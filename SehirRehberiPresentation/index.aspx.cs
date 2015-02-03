using Ext.Net;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SehirRehberiPresentation
{
    public partial class index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void GenelAramaForm(object sender, DirectEventArgs e)
        {
            Window popup = new Window
            {
                ID = "Genel Arama",
                Title = "Genel Arama",
                Height = 120,
                Width = 280,
                BodyPadding = 5,
                Resizable = false,
                Draggable = false,
                Modal = true,
                CloseAction = CloseAction.Destroy,
                Loader = new ComponentLoader
                {
                    Url = "genelArama.aspx",
                    Mode = LoadMode.Frame,
                    LoadMask =
                    {
                        ShowMask = true
                    }
                }

            };
            popup.Render(this.Form);
        }
        protected void OnemliYerAramaForm(object sender, DirectEventArgs e)
        {
            Window popup = new Window
            {
                ID = "onemliYerArama",
                Title = "Önemli Yer Arama",
                Height = 180,
                Width = 280,
                BodyPadding = 5,
                Resizable = false,
                Draggable = false,
                Modal = true,
                CloseAction = CloseAction.Destroy,
                Loader = new ComponentLoader
                {
                    Url = "onemliYerArama.aspx",
                    Mode = LoadMode.Frame,
                    LoadMask =
                    {
                        ShowMask = true
                    }
                }

            };
            popup.Render(this.Form);
        }
        protected void AdresAramaForm(object sender, DirectEventArgs e)
        {
            Window popup = new Window
            {
                ID = "adresArama",
                Title = "Adres Arama",
                Height = 180,
                Width = 280,
                BodyPadding = 5,
                Resizable = false,
                Draggable = false,
                Modal = true,
                CloseAction = CloseAction.Destroy,
                Loader = new ComponentLoader
                {
                    Url = "adresArama.aspx",
                    Mode = LoadMode.Frame,
                    LoadMask =
                    {
                        ShowMask = true
                    }
                }

            };
            popup.Render(this.Form);
        }
        protected void SehriKonya(object sender, DirectEventArgs e)
        {
            Window popup = new Window
            {
                ID = "sehriKonya",
                Title = "Sehri Konya",
                Height = 337,
                Width = 290,
                BodyPadding = 5,
                Resizable = false,
                Draggable = false,
                Modal = true,
                CloseAction = CloseAction.Destroy,
                Loader = new ComponentLoader
                {
                    Url = "sehriKonya.aspx",
                    Mode = LoadMode.Frame,
                    LoadMask =
                    {
                        ShowMask = true
                    }
                }

            };
            popup.Render(this.Form);
        }
        protected void btn_ilceler(object sender, EventArgs e)
        {
            RunCMD();
        }
        protected void btn_eczane(object sender, EventArgs e)
        {
            RunCMD2();
        }

        public void RunCMD2()
        {
            
            string cmd = "cmd";
            string enter = "/c";
            

            string exe =
                " ogr2ogr -f \"GeoJSON\" -t_srs WGS84 " +
                "C:\\json\\poi42.json " +
                "C:\\poi42.TAB";


            try
            {
                Process p = new Process();
                p.StartInfo = new ProcessStartInfo(cmd, enter + exe);
                p.StartInfo.WindowStyle = ProcessWindowStyle.Hidden;
                p.Start();
                p.WaitForExit();

            }
            catch (Exception)
            {
                //string script1 = "alert('Dosya/Dosyalar Yüklenemiyor !');";
                //ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert1", script1, true);
            }


            string json = ReadJSON("C:\\json\\poi42.json");

            

            string str = "eczane(" + json + ");";
            ResourceManager1.AddScript(str);
        } //eczaneler için

        public void RunCMD()
        {
            

                        string cmd = "cmd";
                        string enter = "/c";
                      

                        string exe =
                            " ogr2ogr -f \"GeoJSON\" -t_srs WGS84 " +
                            "C:\\json\\ilce42.json " +
                            "C:\\ilce42.TAB";


                        try
                        {
                            Process p = new Process();
                            p.StartInfo = new ProcessStartInfo(cmd, enter + exe);
                            p.StartInfo.WindowStyle = ProcessWindowStyle.Hidden;
                            p.Start();
                            p.WaitForExit();

                        }
                        catch (Exception)
                        {
                            //string script1 = "alert('Dosya/Dosyalar Yüklenemiyor !');";
                            //ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert1", script1, true);
                        }

                       
                        string json = ReadJSON("C:\\json\\ilce42.json");

                        

                        string str = "ilce(" + json + ");";
                        ResourceManager1.AddScript(str);
                        

                    } //ilçeler için
        
        public string ReadJSON(string jsonPath)
                
        {
 	                FileStream fs = new FileStream(jsonPath, FileMode.Open, FileAccess.Read);
                    StreamReader sr = new StreamReader(fs);
                    string WillReturn = "";

                try
                {
                    WillReturn = sr.ReadToEnd();
                    return WillReturn;
                }
                catch (Exception ex)
                {

                    WillReturn = null;
                    return WillReturn;
                }
                finally { sr.Close(); fs.Dispose(); }
                
        }


    }

}




