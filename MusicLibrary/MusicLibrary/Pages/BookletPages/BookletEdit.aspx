<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/Site.Master" AutoEventWireup="true" CodeBehind="BookletEdit.aspx.cs" Inherits="MusicLibrary.Pages.BookletPages.BookletEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHeader" runat="server">
    <h2 class="pageheader">Nothäfte</h2>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <site:BookletDisplayManipulate runat="server" ID="BookletDisplayManipulate" Mode="Edit" />
</asp:Content>
