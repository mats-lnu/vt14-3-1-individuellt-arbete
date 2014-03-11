<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="BookletPieceDisplayManipulate.ascx.cs" Inherits="MusicLibrary.Pages.Shared.BookletPieceDisplayManipulate" %>

<asp:ListView ID="BookletPiecesListView"
    runat="server"
    DataKeyNames="PieceID"
    ItemType="MusicLibrary.Model.BLL.Piece"
    SelectMethod="BookletPiecesListView_GetData"
    OnItemDataBound="BookletPiecesListView_ItemDataBound">
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
                    <th>Kompositionsår</th>
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
                <asp:Literal ID="composerLiteral" runat="server" Text="Kompositör i klartext" />
            </td>
            <td>
                <asp:Literal ID="nameLiteral" runat="server" Text="<%#: Item.Name %>" />
            </td>
            <td>
                <asp:Literal ID="catalogueNumberLiteral" runat="server" Text="<%#: Item.CatalogueNumber %>" />
            </td>
            <td>
                <asp:Literal ID="scaleLiteral" runat="server" Text="Tonart i klartext" />
            </td>
            <td>
                <asp:Literal ID="instrumentsLiteral" runat="server" Text="Instrument, Instrument, Instrument" />
            </td>
            <td>
                <asp:Literal ID="genreLiteral" runat="server" Text="Genre i klartext" />
            </td>
            <td>
                <asp:Literal ID="yearOfCompositionLiteral" runat="server" Text="<%#: Item.YearOfComposition.Year %>" />
            </td>
        </tr>
    </ItemTemplate>
    <EmptyDataTemplate>
        <p>Nothäftet har inget innehåll.</p>
    </EmptyDataTemplate>
</asp:ListView>
