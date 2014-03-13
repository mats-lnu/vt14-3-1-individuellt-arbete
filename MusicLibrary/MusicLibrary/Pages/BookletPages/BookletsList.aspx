<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/Site.Master" AutoEventWireup="true" CodeBehind="BookletsList.aspx.cs" Inherits="MusicLibrary.Pages.BookletPages.BookletsList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHeader" runat="server">
    <h2 class="pageheader">Nothäften</h2>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <asp:ListView ID="ListViewBooklets"
        runat="server"
        ItemType="MusicLibrary.Model.BLL.Booklet"
        SelectMethod="ListViewBooklets_GetData"
        DataKeyNames="BookletID"
        OnItemDataBound="ListViewBooklets_ItemDataBound">

        <LayoutTemplate>
            <%-- Success message --%>
            <asp:PlaceHolder ID="SuccessMessagePlaceHolder" runat="server" Visible="false" >
                <div data-alert="data-alert" class="alert-box success">
                    <p>
                        <asp:Literal ID="SuccessMessageLiteral" runat="server" />
                    </p>
                    <a href="#" class="close">&times;</a>
                </div>
            </asp:PlaceHolder>

            <%-- Error message --%>

            <asp:PlaceHolder ID="itemPlaceholder" runat="server" />
        </LayoutTemplate>

        <ItemTemplate>
            <div class="row">
                <div class="small-12 large-10 columns booklet-card">
                    <div class="booklet-card-info small-12 medium-9 large-10 columns">
                        <p><span class="custom-label">Titel: </span>
                            <asp:Literal ID="nameLabel" runat="server" Text="<%#: Item.Name %>" />
                        </p>
                        <p><span class="custom-label">Kompositörer: </span>
                            <asp:Literal ID="composersLabel" runat="server" Text="Kompositör; Kompositör" />
                        </p>
                        <p><span class="custom-label">Förlag: </span>
                            <asp:Literal ID="publisherLabel" runat="server" Text="Förlag" />
                        </p>
                        <p><span class="custom-label">Utgivningsår: </span>
                            <asp:Literal ID="yearOfPubliationLabel" runat="server" Text="<%#: Item.YearOfPublication.Year %>" />
                        </p>
                        <p><span class="custom-label">Hylla: </span>
                            <asp:Literal ID="placeLabel" runat="server" Text="<%#: Item.Place %>"></asp:Literal>
                        </p>
                    </div>
                    <div class="booklet-card-buttons small-12 medium-3 large-2 columns">
                        <ul class="button-list">
                            <li>
                                <asp:LinkButton ID="LinkButton1" CssClass="button" ToolTip="Radera nothäftet" runat="server">
                                    <asp:Image ID="Image1" ImageUrl="~/Content/Icons/Delete-icon-smaller.png" AlternateText="Radera nothäftet" runat="server" />
                                </asp:LinkButton>
                            </li>
                            <li>
                                <asp:HyperLink ID="ImageHyperlink" CssClass="button" NavigateUrl='<%# GetRouteUrl("BookletDetails", new { id = Item.BookletID }) %>' ImageUrl="~/Content/Icons/Details-icon-smaller.png" ToolTip="Visa Detaljer" runat="server" Text="Visa detaljer" />
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
