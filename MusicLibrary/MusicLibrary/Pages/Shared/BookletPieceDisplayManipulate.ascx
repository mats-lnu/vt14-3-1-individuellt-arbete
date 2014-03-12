<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="BookletPieceDisplayManipulate.ascx.cs" Inherits="MusicLibrary.Pages.Shared.BookletPieceDisplayManipulate" %>

<asp:ListView ID="BookletPiecesListView"
    runat="server"
    DataKeyNames="PieceID"
    ItemType="MusicLibrary.Model.BLL.Piece"
    SelectMethod="BookletPiecesListView_GetData"
    OnItemDataBound="BookletPiecesListView_ItemDataBound"
    InsertItemPosition="LastItem"
    OnPreRender="BookletPiecesListView_PreRender">

    <LayoutTemplate>
        <table>
            <thead>
                <tr>
                    <th>Kompositör</th>
                    <th>Titel</th>
                    <th>Katalognummer</th>
                    <th>Tonart</th>
                    <th>Instrument</th>
                    <th>Genre</th>
                    <asp:PlaceHolder ID="EditHeaderColumnPlaceHolder" runat="server" Visible="true" OnPreRender="PlaceHolder_PreRender">
                        <th></th>
                    </asp:PlaceHolder>
                </tr>
            </thead>
            <tbody>
                <asp:PlaceHolder ID="itemPlaceholder" runat="server" />
            </tbody>
        </table>
    </LayoutTemplate>

    <ItemTemplate>
        <tr>
            <td>
                <asp:Literal ID="composerLiteral" runat="server" Text="Kompositör" />
            </td>
            <td>
                <asp:Literal ID="nameLiteral" runat="server" Text="<%#: Item.Name %>" />
            </td>
            <td>
                <asp:Literal ID="catalogueNumberLiteral" runat="server" Text="<%#: Item.CatalogueNumber %>" />
            </td>
            <td>
                <asp:Literal ID="scaleLiteral" runat="server" Text="Tonart" />
            </td>
            <td>
                <asp:Literal ID="instrumentsLiteral" runat="server" Text="Instrument, Instrument, Instrument" />
            </td>
            <td>
                <asp:Literal ID="genreLiteral" runat="server" Text="Genre" />
            </td>
            <asp:PlaceHolder ID="EditColumnPlaceHolder" runat="server" Visible="true" OnPreRender="PlaceHolder_PreRender">
                <td class="buttonColumn">
                    <asp:LinkButton ID="DeleteLinkButton" CssClass="button" CommandName="Delete" runat="server" ToolTip="Radera">
                        <asp:Image ID="DeleteImage" runat="server" ImageUrl="~/Content/Icons/Delete-icon-smaller.png" AlternateText="Radera" />
                    </asp:LinkButton>
                </td>
            </asp:PlaceHolder>
        </tr>
    </ItemTemplate>

    <InsertItemTemplate>
        <tr>
            <td colspan="6">
                <label class="custom-label">
                    Lägg till ny:
                <asp:DropDownList ID="PieceDropDownList" runat="server" OnLoad="PieceDropDownList_Load" />
                </label>
            </td>
            <td class="buttonColumn">
                <asp:LinkButton ID="InsertLinkButton" CssClass="button" CommandName="Insert" runat="server" ToolTip="Spara">
                    <asp:Image ID="SaveImage" runat="server" ImageUrl="~/Content/Icons/Save-icon-smaller.png" AlternateText="Spara" />
                </asp:LinkButton>
            </td>
        </tr>
    </InsertItemTemplate>

    <EmptyDataTemplate>
        <p>Nothäftet har inget innehåll.</p>
    </EmptyDataTemplate>

</asp:ListView>
