<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/Site.Master" AutoEventWireup="true" CodeBehind="BookletEdit.aspx.cs" Inherits="MusicLibrary.Pages.BookletPages.BookletEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHeader" runat="server">
    <h2 class="pageheader">Nothäfte</h2>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <div class="row">
        <div class="small-12 large-10 columns booklet-details-card">
            <%-- Success message --%>
            <asp:PlaceHolder ID="SuccessMessagePlaceHolder" runat="server" Visible="false" >
                <div data-alert="data-alert" class="alert-box success">
                    <p>
                        <asp:Literal ID="SuccessMessageLiteral" runat="server" />
                    </p>
                    <a href="#" class="close">&times;</a>
                </div>
            </asp:PlaceHolder>

            <%-- User Control for editing the Booklet --%>
            <site:BookletDisplayManipulate runat="server" ID="BookletDisplayManipulate" Mode="Edit" />

        </div>
    </div>
</asp:Content>
