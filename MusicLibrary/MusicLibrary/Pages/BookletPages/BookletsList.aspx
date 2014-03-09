<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/Site.Master" AutoEventWireup="true" CodeBehind="BookletsList.aspx.cs" Inherits="MusicLibrary.Pages.BookletPages.BookletsList" %>

<asp:Content ID="Content" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <asp:ListView ID="ListViewBooklets" runat="server" ItemType="MusicLibrary.Model.BLL.Booklet" SelectMethod="ListViewBooklets_GetData" DataKeyNames="BookletID">
        <LayoutTemplate>
            <asp:PlaceHolder ID="itemPlaceholder" runat="server" />
        </LayoutTemplate>
        <ItemTemplate>
            <div class="row">
                <div class="small-12 large-10 columns booklet-card">
                    <div class="booklet-card-info small-12 medium-9 large-10 columns">
                        <p><span class="custom-label">Titel: </span><%#: Item.Name %></p>
                        <p><span class="custom-label">Kompositörer: </span>Kompositör i klartext; Kompositör i klartext</p>
                        <p><span class="custom-label">Förlag: </span>Förlag i klartext</p>
                        <p><span class="custom-label">Utgivningsår: </span><%#: Item.YearOfPublication.Year %></p>
                    </div>
                    <div class="booklet-card-buttons small-12 medium-3 large-2 columns">
                        <ul class="button-list">
                            <li>
                                <asp:ImageButton CssClass="button" ID="ImageButton2" runat="server" ImageUrl="~/Content/Icons/Delete-icon-smaller.png" AlternateText="Radera nothäftet" ToolTip="Radera nothäftet" />
                            </li>
                            <li>
                                <asp:ImageButton CssClass="button" ID="ImageButton1" runat="server" ImageUrl="~/Content/Icons/Details-icon-smaller.png" AlternateText="Visa detaljer" ToolTip="Visa detaljer" />
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </ItemTemplate>
        <EmptyDataTemplate>
            <p>Inga nothäften hittades.</p>
        </EmptyDataTemplate>
    </asp:ListView>
</asp:Content>
