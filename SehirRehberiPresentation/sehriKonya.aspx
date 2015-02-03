<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="genelArama.aspx.cs" Inherits="SehirRehberiPresentation.genelArama" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
</head>
<body>

    <ext:ResourceManager runat="server" ID="ResourceManager1">
    </ext:ResourceManager>



    <ext:DropDownField ID="ilce_Adi" runat="server" FieldLabel="İlçe Adı" TriggerIcon="Search">
    </ext:DropDownField>


    <ext:RadioGroup ID="RadioGroup1" runat="server" GroupName="sehriKonya" ColumnsNumber="1">
        
        <Items>
            <ext:Radio runat="server" FieldLabel="Camiler ve Külliyeler" LabelWidth="200"></ext:Radio>
            <ext:Radio runat="server" FieldLabel="Çeşme ve Sarnıçlar" LabelWidth="200"></ext:Radio>
            <ext:Radio runat="server" FieldLabel="Güneş Saatleri" LabelWidth="200"></ext:Radio>
            <ext:Radio runat="server" FieldLabel="Hamamlar" LabelWidth="200"></ext:Radio>
            <ext:Radio runat="server" FieldLabel="Kamu Kurumları ve Önemli Binalar" LabelWidth="200"></ext:Radio>
            <ext:Radio runat="server" FieldLabel="Kütüphaneler" LabelWidth="200"></ext:Radio>
            <ext:Radio runat="server" FieldLabel="Tekkeler" LabelWidth="200"></ext:Radio>
            <ext:Radio runat="server" FieldLabel="Semtler Mekanlar" LabelWidth="200"></ext:Radio>
            <ext:Radio runat="server" FieldLabel="Ziyaret Mekanları" LabelWidth="200"></ext:Radio> 

        </Items>
    </ext:RadioGroup>
    
    <ext:Button runat="server" ID="btn_sehriKonyaAra" Text="Ara" Width="250" Height="30">

    </ext:Button>




</body>
</html>
