<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/Site.Master" AutoEventWireup="true" CodeBehind="BookletDetails.aspx.cs" Inherits="MusicLibrary.Pages.BookletPages.BookletDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHeader" runat="server">
    <h2 class="pageheader">Nothäfte</h2>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <div class="row">
        <div class="small-12 large-10 columns booklet-details-card">

            <%-- User Control for displaying the Booklet-details. --%>
            <site:BookletDisplayManipulate runat="server" ID="BookletDisplayManipulate" />

        </div>
    </div>
</asp:Content>
