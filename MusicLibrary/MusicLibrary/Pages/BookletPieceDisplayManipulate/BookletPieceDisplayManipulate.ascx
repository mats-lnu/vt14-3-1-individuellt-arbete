<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="BookletPieceDisplayManipulate.ascx.cs" Inherits="MusicLibrary.Pages.Shared.BookletPieceDisplayManipulate" %>

<asp:ListView ID="BookletPiecesListView"
    runat="server"
    DataKeyNames="PieceID, BookletID"
    ItemType="MusicLibrary.Model.BLL.BookletContent"
    SelectMethod="BookletPiecesListView_GetData"
    DeleteMethod="BookletPiecesListView_DeleteItem"
    OnItemDataBound="BookletPiecesListView_ItemDataBound" InsertMethod="BookletPiecesListView_InsertItem"
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
                <asp:Literal ID="composerLiteral" runat="server" Text="" />
            </td>
            <td>
                <asp:Literal ID="nameLiteral" runat="server" Text="" />
            </td>
            <td>
                <asp:Literal ID="catalogueNumberLiteral" runat="server" Text="" />
            </td>
            <td>
                <asp:Literal ID="scaleLiteral" runat="server" Text="" />
            </td>
            <td>
                <asp:Literal ID="instrumentsLiteral" runat="server" Text="" />
            </td>
            <td>
                <asp:Literal ID="genreLiteral" runat="server" Text="" />
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
                <asp:DropDownList ID="PieceDropDownList"
                    ItemType="MusicLibrary.Model.BLL.Piece"
                    DataValueField="PieceID"
                    SelectMethod="PieceDropDownList_GetData"
                    DataTextField="PieceID"
                    SelectedValue="<%# BindItem.PieceID %>"
                    runat="server" OnPreRender="PieceDropDownList_PreRender" />
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
