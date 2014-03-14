<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/Site.Master" AutoEventWireup="true" CodeBehind="BookletDetails.aspx.cs" Inherits="MusicLibrary.Pages.BookletPages.BookletDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHeader" runat="server">
    <h2 class="pageheader">Nothäfte</h2>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <div class="row">
        <div class="small-12 large-10 columns booklet-details-card">

            <%-- Success message --%>
            <asp:PlaceHolder ID="SuccessMessagePlaceHolder" runat="server" Visible="false">
                <div data-alert="data-alert" class="alert-box success">
                    <p>
                        <asp:Literal ID="SuccessMessageLiteral" runat="server" />
                    </p>
                    <a href="#" class="close">&times;</a>
                </div>
            </asp:PlaceHolder>

            <%-- Validation Summary for booklet edit --%>
            <asp:ValidationSummary ID="BookletEditValidationSummary" data-alert="data-alert" CssClass="alert-box error" runat="server" ShowModelStateErrors="true" DisplayMode="List" />

            <%-- User Control for displaying the Booklet-details. --%>
            <site:BookletDisplayManipulate runat="server" ID="BookletDisplayManipulate" />

        </div>
    </div>
</asp:Content>
