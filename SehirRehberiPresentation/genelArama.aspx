<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="genelArama.aspx.cs" Inherits="SehirRehberiPresentation.genelArama" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="js.js"></script>
    <script src="openlayer.js"></script>
    <title></title>


</head>
<body>

    <ext:ResourceManager runat="server" ID="ResourceManager1">
    </ext:ResourceManager>


    
            <ext:DropDownField ID="ilce_Adi" runat="server" FieldLabel="İlçe Adı" TriggerIcon="Search">
            </ext:DropDownField>

            <ext:DropDownField ID="tur_Adi" runat="server" FieldLabel="Tür Adı" TriggerIcon="Search">
            </ext:DropDownField>

            <ext:Button runat="server" ID="btn_genelarama" Text="Ara" Width="255" Height="30">
            </ext:Button>
       


</body>
</html>
