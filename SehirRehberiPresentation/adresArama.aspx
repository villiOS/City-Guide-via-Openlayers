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

    <ext:TextField ID="txt_CaddeSokak" FieldLabel="Cad/Sokak" runat="server">
        <RightButtons>
            <ext:Button runat="server" ID="btn_CaddeSokakAra" Text="Ara">
            
            </ext:Button>
        </RightButtons>
    </ext:TextField>

    <ext:TextField ID="txt_KapiNo" FieldLabel="Kapı No" runat="server">
        <RightButtons>
            <ext:Button runat="server" ID="btn_KapiNo" Text="Ara"> 

            </ext:Button>
        </RightButtons>
    </ext:TextField>


    <ext:Button runat="server" ID="btn_genelarama" Text="Ara" Width="255" Height="30">
    </ext:Button>



</body>
</html>
