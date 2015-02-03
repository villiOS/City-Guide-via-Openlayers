<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="SehirRehberiPresentation.index" %>

<!DOCTYPE html>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <title></title>
    <link href="style.css" rel="stylesheet" />
    <link href="default.css" rel="stylesheet" />
    <script src="openlayer.js"></script>
    <script src="js.js"></script>
    <script src="utf8.js"></script>
    <script type="text/javascript" src="http://maps.google.com/maps/api/js?v=3&amp;sensor=false"></script>
    <script type="text/javascript">
        var map;
        var apiKey = "AqTGBsziZHIJYYxgivLBf0hVdrAk9mWO5cQcb8Yux8sW5M8c8opEC2lZqKR1ZZXf"; //bing map api
        var googleMapHybrid, googleMapRoad, googleMapSatellite, googleMapTerrain, bingMapAerial, bingMapHybrid, bingMapRoad, osmMap;
        var geojson;
        var vectors;
        var feature;

        function init() {


            map = new OpenLayers.Map({
                div: "map",

            });
            // map.addControl(new OpenLayers.Control.LayerSwitcher());
            map.addControl(new OpenLayers.Control.LayerSwitcher({
                div: document.getElementById('DivPanelBaseLayer')
            }));

            map.addControl(new OpenLayers.Control.MousePosition({
                div: document.getElementById('DivMousePosition')
            }));

            map.addControl(new OpenLayers.Control.MousePosition({
                div: document.getElementById('DivMousePosition2'),
                displayProjection: new OpenLayers.Projection('EPSG:4326')
            }));

            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            googleMapHybrid = new OpenLayers.Layer.Google( //google hibrit tipinde mapi import ediyoruz
                "Google Hibrit Harita",
                {
                    type: google.maps.MapTypeId.HYBRID,
                    numZoomLevels: 20,
                    sphericalMercator: true
                });
            /////////////////////////////////////////////////////////                                                                             
            googleMapSatellite = new OpenLayers.Layer.Google( //google satellite tipinde mapi import ediyoruz
                "Google Uydu Görünümü",
                {
                    type: google.maps.MapTypeId.SATELLITE,
                    numZoomLevels: 20,
                    sphericalMercator: true
                });
            /////////////////////////////////////////////////////////                                                                             
            googleMapRoad = new OpenLayers.Layer.Google( //google yollar tipinde mapi import ediyoruz
                "Google Yol Haritası", // the default
                {
                    numZoomLevels: 20
                });
            /////////////////////////////////////////////////////////                                                                             
            googleMapTerrain = new OpenLayers.Layer.Google( //google yer şekilleri tipinde mapi import ediyoruz
                "Google Yer Şekilleri Haritası",
                {
                    type: google.maps.MapTypeId.TERRAIN
                    //numZoomLevels: 20
                });
            /////////////////////////////////////////////////////////                                                                             
            osmMap = new OpenLayers.Layer.OSM("OSM Klasik Harita"); //openStreetMap tipinde mapi import ediyoruz
            /////////////////////////////////////////////////////////                                                                             
            bingMapRoad = new OpenLayers.Layer.Bing({ //bing yollar tipinde mapi import ediyoruz
                name: "Bing Yol Haritası",
                key: apiKey,
                type: "Road"
            });
            /////////////////////////////////////////////////////////                                                                              
            bingMapHybrid = new OpenLayers.Layer.Bing({ //google satellite-yollar tipinde mapi import ediyoruz
                name: "Bing Hibrit Harita",
                key: apiKey,
                type: "AerialWithLabels"
            });
            /////////////////////////////////////////////////////////                                                                              
            bingMapAerial = new OpenLayers.Layer.Bing({ //google satellite tipinde mapi import ediyoruz
                name: "Bing Uydu Haritası",
                key: apiKey,
                type: "Aerial"
            });
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            // map.addLayer(osmMap);

            vectors =
                new OpenLayers.Layer.Vector("KATMANLAR", { isBaseLayer: false }),
            map.addLayer(vectors);

            // note that first layer must be visible
            map.addLayers(
                [
                    googleMapHybrid,
                    googleMapRoad,
                    googleMapSatellite,
                    googleMapTerrain,
                    bingMapAerial,
                    bingMapHybrid,
                    bingMapRoad,
                    osmMap//,
                    //vectors
                ]
            );
            vectors.events.on({ //çizdiğimiz şekillerin olaylarını tutuyor.
                "featureselected": fnfeatureselected

            });
            var options = {
                hover: false
            };
            var select = new OpenLayers.Control.SelectFeature(vectors, options);
            map.addControl(select);
            select.activate();
            //////map.zoomToMaxExtent();

            map.setCenter(new OpenLayers.LonLat(32.850591, 37.580815).transform( //haritamızı global olarak tanımladığım koordinatlara belirtilen zoom ölçeğine göre set ettik
                new OpenLayers.Projection("EPSG:4326"),
                map.getProjectionObject()
                ), 10);

            geojson = new OpenLayers.Format.GeoJSON({
                'internalProjection': map.baseLayer.projection,
                'externalProjection': new OpenLayers.Projection("EPSG:4326")
            });


            function fnfeatureselected(e) {
                var feature = e.feature;



                var shape = feature.attributes;

                var adi = shape["ADI"];
                var kategori = shape["KATEGORİ"];
                var ustkategori = shape["USTKATEGORI"];
                var ilceadi = shape["ILCEADI"];
                var ilce = shape["ILCE"];
                var ilcekod = shape["ILCEKOD"];
                var semtkoybelde = shape["SEMTKOYBELDE"];
                var mahalle = shape["MAHALLE"];
                var cadde = shape["BULVARCADDE"];
                var sokak = shape["SOKAK"];
                var kapino = shape["BINAKAPINO"];
                var il = shape["IL"];


          //      if (shape["ILCEADI"] == "Meram") { alert("Merama Tıklandı"); } // çalışıyor

               
                if (shape == null) {
                    Ext.Msg.alert('Hata', 'Lütfen Sayfayı Yenileyiniz..');
                }
                else {






                    if (adi == null) { adi = ""; }
                    if (kategori == null) { kategori = ""; }
                    if (ustkategori == null) { ustkategori = ""; }
                    if (ilceadi == null) { ilceadi = ""; }
                    if (ilcekod == null) { ilcekod = ""; }
                    if (semtkoybelde == null) { semtkoybelde = ""; }
                    if (mahalle == null) { mahalle = ""; }
                    if (cadde == null) { cadde = ""; }
                    if (sokak == null) { sokak = ""; }
                    if (kapino == null) { kapino = ""; }
                    if (il == null) { il = ""; }
                    if (ilce == null) { ilce = ""; }

                    Ext.Msg.alert('INFORMATIONS',
                        "<br \>ADI:" + adi +
                        "<br \> KATEGORİ: " + kategori +
                        "<br \> USTKATEGORİ: " + ustkategori +
                        "<br \> SEMT/KÖY/BELDE: " + semtkoybelde +
                        "<br \> MAHALLE: " + mahalle +
                        "<br \> CADDE: " + cadde +
                        "<br \> SOKAK: " + sokak +
                        "<br \> KAPINO: " + kapino +
                        "<br \> İLÇE ADI: " + ilceadi +
                        "<br \> İLÇE ADI: " + ilce +
                        "<br \> İLÇEKOD: " + ilcekod +
                        "<br \> İL ADI: " + il
                        );
                }
            }


        }

        function eczane(json) {
            var features = geojson.read(json);
            var bounds;
            if (features) {
                if (features.constructor != Array) {
                    features = [features];
                }
                for (var i = 0; i < features.length; i++) {
                    if (!bounds) {
                        bounds = features[i].geometry.getBounds();
                    }
                    else {
                        bounds.extend(features[i].geometry.getBounds());
                    }
                }
                vectors.addFeatures(features);
                map.zoomToExtent(bounds);
            }
        }


        function ilce(json) { //GEOJSON I, ÇİZİLMİŞ ŞEKLE DÖNÜŞTÜRÜYOR

            var features = geojson.read(json);
            //var features = json.read(element.value);
            var bounds;

            if (features) {
                if (features.constructor != Array) {
                    features = [features];
                }
                for (var i = 0; i < features.length; ++i) {
                    if (!bounds) {
                        bounds = features[i].geometry.getBounds();
                    } else {
                        bounds.extend(features[i].geometry.getBounds());
                    }

                }

                vectors.addFeatures(features);
                map.zoomToExtent(bounds);

            }
        }
        //////////////////////////////////////////////////////////////////////
        function serialize() {


            //var bilgi = geojson.write(vectors.features, false);
            //alert(bilgi);
            //document.getElementById('txtbilgi').value = bilgi;

        }
        //////////////////////////////////////////////////////////////////////


        function ara() {
            var ilce = document.getElementById('ilce').value;

            document.getElementById('il').innerHTML = ilce;
             
            
            
        }



    </script>

</head>
<body onload="init()">
    <form id="form1" runat="server">
        <div>

            <ext:ResourceManager runat="server" ID="ResourceManager1"></ext:ResourceManager>


            <ext:Viewport runat="server" Layout="border">
                <Items>
                    <ext:Panel runat="server" Height="50" Title="MENULER" Region="North" Collapsible="True" Split="True">
                        <Items></Items>
                    </ext:Panel>

                    <ext:Panel runat="server" Title="HIZLI ERİŞİM" Width="270" Region="East" Collapsible="true" Split="false" Layout="accordion">

                        <Items>
                            <ext:Panel ID="panel1" runat="server" Border="false" Collapsed="True" Icon="Map" Title="Adres Ve Nokta Arama">
                                <Items>
                                   
                                    <ext:DropDownField ID="il" runat="server" FieldLabel="İl" TriggerIcon="Search" Text="Konya">

                                    </ext:DropDownField>
                                   
                                    <ext:DropDownField ID="ilce" runat="server" FieldLabel="İlçe" TriggerIcon="Search" Text="denemeasd">
                                       
                                    </ext:DropDownField>
                                    
                                    <ext:DropDownField ID="mahalle" runat="server" FieldLabel="Mahalle" TriggerIcon="Search">

                                    </ext:DropDownField>
                                    
                                    <ext:DropDownField ID="yol" runat="server" FieldLabel="Yol" TriggerIcon="Search">

                                    </ext:DropDownField>

                                    <ext:Button runat="server" ID="btn_adresNoktaArama" Text="Ara" OnClientClick="ara">

                                    </ext:Button>

                                </Items>
                            </ext:Panel>
                            <ext:Panel ID="panel2" runat="server" Border="false" Collapsed="true" Icon="Layers" Title="Katman">
                                <Items>
                                    <ext:Button ID="Button1"
                                        ToggleGroup="katman"
                                        runat="server"
                                        Text="Rehber"
                                        Width="175">
                                    </ext:Button>
                                </Items>
                            </ext:Panel>
                            <ext:Panel ID="panel3" runat="server" Border="false" Collapsed="True" Icon="StarGold" Title="Güncel">
                                <Items>
                                    <ext:Button ID="Button2"
                                        runat="server"
                                        Text="İlçeler"
                                        Width="175">
                                        <DirectEvents>
                                            <Click OnEvent="btn_ilceler"></Click>
                                        </DirectEvents>
                                    </ext:Button>
                                    <ext:Button ID="Button3"
                                        runat="server"
                                        Text="Güncel Olaylar"
                                        Width="175">
                                    </ext:Button>
                                    <ext:Button ID="Button4"
                                        runat="server"
                                        Text="Belediyeler"
                                        Width="175">
                                    </ext:Button>
                                    <ext:Button ID="Button5"
                                        runat="server"
                                        Text="Kaymakamlıklar"
                                        Width="175">
                                    </ext:Button>
                                    <ext:Button ID="Button6"
                                        runat="server"
                                        Text="Hastanaler"
                                        Width="175">
                                    </ext:Button>
                                    <ext:Button ID="Button7"
                                        runat="server"
                                        Text="Nöbetçi Eczaneler"
                                        Width="175">
                                    </ext:Button>
                                    <ext:Button ID="Button8"
                                        runat="server"
                                        Text="İtfaiye"
                                        Width="175">
                                    </ext:Button>
                                    <ext:Button ID="Button9"
                                        runat="server"
                                        Text="İski Havzaları"
                                        Width="175">
                                    </ext:Button>
                                    <ext:Button ID="Button10"
                                        runat="server"
                                        Text="İletişim Noktaları"
                                        Width="175">
                                    </ext:Button>
                                    <ext:Button ID="Button11"
                                        runat="server"
                                        Text="Kışla Mücadele Araçları"
                                        Width="175">
                                    </ext:Button>
                                </Items>
                            </ext:Panel>
                            <ext:Panel ID="panel4" runat="server" Border="false" Collapsed="true" Icon="Accept" Title="Konya">
                                <Items>
                                    <ext:Button ID="Button12"
                                        runat="server"
                                        Text="Eczaneler"
                                        Width="175">
                                        <DirectEvents>
                                            <Click OnEvent="btn_eczane"></Click>
                                        </DirectEvents>
                                    </ext:Button>
                                    <ext:Button ID="Button13"
                                        runat="server"
                                        Text="Şehr-i Konya"
                                        Width="175">
                                    </ext:Button>
                                    <ext:Button ID="Button14"
                                        runat="server"
                                        Width="175"
                                        Text="Öneri Şikayet">
                                    </ext:Button>
                                    <ext:Button ID="Button15"
                                        runat="server"
                                        Text="Diğer Türler"
                                        Width="175">
                                    </ext:Button>
                                </Items>
                            </ext:Panel>
                            <ext:Panel ID="panel5" runat="server" Border="false" Collapsed="True" Icon="Find" Title="Arama">
                                <Items>
                                    <ext:Button ID="Button16"
                                        ToggleGroup="arama"
                                        runat="server"
                                        Text="Genel Arama"
                                        Width="175">
                                    </ext:Button>
                                    <ext:Button ID="Button17"
                                        ToggleGroup="arama"
                                        runat="server"
                                        Text="Adres Arama"
                                        Width="175">
                                    </ext:Button>
                                    <ext:Button ID="Button18"
                                        ToggleGroup="arama"
                                        runat="server"
                                        Text="Önemli Yer Arama"
                                        Width="175">
                                    </ext:Button>
                                    <ext:Button ID="Button19"
                                        ToggleGroup="arama"
                                        runat="server"
                                        Text="Güzergah"
                                        Width="175">
                                    </ext:Button>
                                    <ext:Button ID="Button20"
                                        ToggleGroup="arama"
                                        runat="server"
                                        Text="Hızlı Erişim"
                                        Width="175">
                                    </ext:Button>
                                    <ext:Button ID="Button21"
                                        ToggleGroup="arama"
                                        runat="server"
                                        Text="Yardım-Detay"
                                        Width="175">
                                    </ext:Button>

                                </Items>
                            </ext:Panel>
                            <ext:Panel ID="panel6" runat="server" Border="false" Collapsed="true" Icon="Mail" Title="E-Posta">
                                <Items>
                                    <ext:Button ID="Button22"
                                        ToggleGroup="mail"
                                        runat="server"
                                        Text="Mail At"
                                        Width="175">
                                    </ext:Button>
                                </Items>
                            </ext:Panel>
                            <ext:Panel ID="panel7" runat="server" Border="false" Collapsed="true" Icon="PluginAdd" Title="Language">
                                <Items>
                                    <ext:Button ID="Button23"
                                        ToggleGroup="dil"
                                        runat="server"
                                        Text="Türkçe"
                                        Width="175">
                                    </ext:Button>
                                    <ext:Button ID="Button24"
                                        ToggleGroup="dil"
                                        runat="server"
                                        Text="Arabic"
                                        Width="175">
                                    </ext:Button>
                                    <ext:Button ID="Button25"
                                        ToggleGroup="dil"
                                        runat="server"
                                        Text="English"
                                        Width="175">
                                    </ext:Button>
                                </Items>
                            </ext:Panel>

                        </Items>
                    </ext:Panel>

                    <ext:Panel runat="server" Height="70" Title="KOORDİNAT" Region="South" Collapsible="true" Split="true">
                        <Items>
                            <ext:Container ID="Container1" runat="server">
                                <Content>
                                    <center><div id="DivMousePosition"></div></center>
                                    <p>
                                        <center><div id="DivMousePosition2"></div></center>
                                    </p>
                                </Content>
                            </ext:Container>

                        </Items>
                    </ext:Panel>
                    <ext:Panel runat="server" Title="AYARLAR" Width="175" Region="West" Collapsible="true" Split="false" Layout="accordion">
                        <Items>
                            <ext:Panel ID="panel_harita" runat="server" Border="false" Collapsed="True" Icon="Map" Title="Haritalar">
                                <Items>
                                    <ext:Container runat="server">
                                        <Content>
                                            <div id="DivPanelBaseLayer"></div>
                                        </Content>
                                    </ext:Container>

                                </Items>
                            </ext:Panel>
                            <ext:Panel ID="panel_katman" runat="server" Border="false" Collapsed="true" Icon="Layers" Title="Katman">
                                <Items>
                                    <ext:Button ID="btn_katman1"
                                        ToggleGroup="katman"
                                        runat="server"
                                        Text="Rehber"
                                        Width="175">
                                    </ext:Button>
                                </Items>
                            </ext:Panel>
                            <ext:Panel ID="panel_guncel" runat="server" Border="false" Collapsed="True" Icon="StarGold" Title="Güncel">
                                <Items>
                                    <ext:Button ID="btn_guncel0"
                                        runat="server"
                                        Text="İlçeler"
                                        Width="175">
                                        <DirectEvents>
                                            <Click OnEvent="btn_ilceler"></Click>
                                        </DirectEvents>
                                    </ext:Button>
                                    <ext:Button ID="btn_guncel1"
                                        runat="server"
                                        Text="Güncel Olaylar"
                                        Width="175">
                                    </ext:Button>
                                    <ext:Button ID="btn_guncel2"
                                        runat="server"
                                        Text="Belediyeler"
                                        Width="175">
                                    </ext:Button>
                                    <ext:Button ID="btn_guncel3"
                                        runat="server"
                                        Text="Kaymakamlıklar"
                                        Width="175">
                                    </ext:Button>
                                    <ext:Button ID="btn_guncel4"
                                        runat="server"
                                        Text="Hastanaler"
                                        Width="175">
                                    </ext:Button>
                                    <ext:Button ID="btn_guncel5"
                                        runat="server"
                                        Text="Nöbetçi Eczaneler"
                                        Width="175">
                                    </ext:Button>
                                    <ext:Button ID="btn_guncel6"
                                        runat="server"
                                        Text="İtfaiye"
                                        Width="175">
                                    </ext:Button>
                                    <ext:Button ID="btn_guncel7"
                                        runat="server"
                                        Text="İski Havzaları"
                                        Width="175">
                                    </ext:Button>
                                    <ext:Button ID="btn_guncel8"
                                        runat="server"
                                        Text="İletişim Noktaları"
                                        Width="175">
                                    </ext:Button>
                                    <ext:Button ID="btn_guncel9"
                                        runat="server"
                                        Text="Kışla Mücadele Araçları"
                                        Width="175">
                                    </ext:Button>
                                </Items>
                            </ext:Panel>
                            <ext:Panel ID="panel_konya" runat="server" Border="false" Collapsed="true" Icon="Accept" Title="Konya">
                                <Items>
                                    <ext:Button ID="btn_konya1"
                                        runat="server"
                                        Text="Eczaneler"
                                        Width="175">
                                        <DirectEvents>
                                            <Click OnEvent="btn_eczane"></Click>
                                        </DirectEvents>
                                    </ext:Button>
                                    <ext:Button ID="btn_konya2"
                                        runat="server"
                                        Text="Şehr-i Konya"
                                        Width="175">
                                    </ext:Button>
                                    <ext:Button ID="btn_konya3"
                                        runat="server"
                                        Width="175"
                                        Text="Öneri Şikayet">
                                    </ext:Button>
                                    <ext:Button ID="btn_konya4"
                                        runat="server"
                                        Text="Diğer Türler"
                                        Width="175">
                                    </ext:Button>
                                </Items>
                            </ext:Panel>
                            <ext:Panel ID="panel_arama" runat="server" Border="false" Collapsed="True" Icon="Find" Title="Arama">
                                <Items>
                                    <ext:Button ID="btn_arama1"
                                        ToggleGroup="arama"
                                        runat="server"
                                        Text="Genel Arama"
                                        Width="175">
                                    </ext:Button>
                                    <ext:Button ID="btn_arama2"
                                        ToggleGroup="arama"
                                        runat="server"
                                        Text="Adres Arama"
                                        Width="175">
                                    </ext:Button>
                                    <ext:Button ID="btn_arama3"
                                        ToggleGroup="arama"
                                        runat="server"
                                        Text="Önemli Yer Arama"
                                        Width="175">
                                    </ext:Button>
                                    <ext:Button ID="btn_arama4"
                                        ToggleGroup="arama"
                                        runat="server"
                                        Text="Güzergah"
                                        Width="175">
                                    </ext:Button>
                                    <ext:Button ID="btn_arama5"
                                        ToggleGroup="arama"
                                        runat="server"
                                        Text="Hızlı Erişim"
                                        Width="175">
                                    </ext:Button>
                                    <ext:Button ID="btn_arama6"
                                        ToggleGroup="arama"
                                        runat="server"
                                        Text="Yardım-Detay"
                                        Width="175">
                                    </ext:Button>

                                </Items>
                            </ext:Panel>
                            <ext:Panel ID="panel_eposta" runat="server" Border="false" Collapsed="true" Icon="Mail" Title="E-Posta">
                                <Items>
                                    <ext:Button ID="btn_mail1"
                                        ToggleGroup="mail"
                                        runat="server"
                                        Text="Mail At"
                                        Width="175">
                                    </ext:Button>
                                </Items>
                            </ext:Panel>
                            <ext:Panel ID="panel_dil" runat="server" Border="false" Collapsed="true" Icon="PluginAdd" Title="Language">
                                <Items>
                                    <ext:Button ID="btn_dil1"
                                        ToggleGroup="dil"
                                        runat="server"
                                        Text="Türkçe"
                                        Width="175">
                                    </ext:Button>
                                    <ext:Button ID="btn_dil2"
                                        ToggleGroup="dil"
                                        runat="server"
                                        Text="Arabic"
                                        Width="175">
                                    </ext:Button>
                                    <ext:Button ID="btn_dil3"
                                        ToggleGroup="dil"
                                        runat="server"
                                        Text="English"
                                        Width="175">
                                    </ext:Button>
                                </Items>
                            </ext:Panel>

                        </Items>
                    </ext:Panel>

                    <ext:Panel runat="server" Layout="Fit" Title="MAP" Region="Center">
                        <Items>
                            <ext:Container runat="server">
                                <Content>
                                    <div id="map" class="smallmap"></div>
                                </Content>
                            </ext:Container>
                        </Items>
                    </ext:Panel>
                </Items>
            </ext:Viewport>
        </div>
    </form>
</body>
</html>
