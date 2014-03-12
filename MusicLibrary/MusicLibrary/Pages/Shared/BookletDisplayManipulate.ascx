<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="BookletDisplayManipulate.ascx.cs" Inherits="MusicLibrary.Pages.Shared.BookletDisplayManipulate" %>
<%@ Register Src="~/Pages/Shared/BookletPieceDisplayManipulate.ascx" TagPrefix="uc1" TagName="BookletPieceDisplayManipulate" %>


<asp:FormView ID="BookletFormView" runat="server"
    ItemType="MusicLibrary.Model.BLL.Booklet"
    DataKeyNames="BookletID"
    DefaultMode="ReadOnly"
    SelectMethod="BookletFormView_GetItem"
    OnDataBound="BookletFormView_DataBound"
    RenderOuterTable="false"
    OnInit="BookletFormView_Init">

    <ItemTemplate>
        <div class="row">
            <div class="small-12 large-10 columns booklet-details-card">
                <div class="small-12 columns booklet-details-card-info">
                    <p>
                        <span class="custom-label">Titel: </span>
                        <asp:Literal ID="nameLiteral" runat="server" Text="<%#: Item.Name %>" />
                    </p>
                    <p>
                        <span class="custom-label">Förlag: </span>
                        <asp:Literal ID="publisherLiteral" runat="server" Text="Förlag i klartext" />
                    </p>
                    <p>
                        <span class="custom-label">Utgivningsår: </span>
                        <asp:Literal ID="yearOfPublicationLiteral" runat="server" Text="<%#: Item.YearOfPublication.Year %>" />
                    </p>
                    <p>
                        <span class="custom-label">Hylla: </span>
                        <asp:Literal ID="placeLiteral" runat="server" Text="<%#: Item.Place %>" />
                    </p>
                </div>
                <div class="small-12 columns booklet-details-card-pieces">
                    <p><span class="custom-label">Innehåll:</span></p>
                    <%-- A User Control displaying content of the booklet. --%>
                    <uc1:bookletpiecedisplaymanipulate runat="server" id="bookletpiecedisplaymanipulate" bookletid="<%$ routeValue:id %>" />
                </div>
                <div class="booklet-details-card-other small-12 columns">
                    <div class="small-12 medium-9 large-10 columns">
                        <div class="booklet-details-card-other-note small-12 columns">
                            <p>
                                <span class="custom-label">Anteckningar: </span>
                                <asp:Literal ID="notesLiteral" runat="server" Text="Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus fringilla placerat orci, sed lacinia purus tempus eu. Donec tristique ligula." />
                            </p>
                        </div>
                        <div class="booklet-details-card-other-borrowedTo small-12 columns">
                            <p>
                                <span class="custom-label">Utlånad till: </span>
                                <asp:Literal ID="borrowedToLiteral" runat="server" Text="Kompis" />
                            </p>
                        </div>
                    </div>
                    <div class="booklet-details-card-buttons small-12 medium-3 large-2 columns">
                        <ul class="button-list">
                            <li>
                                <asp:HyperLink ID="BackHyperlink" CssClass="button" NavigateUrl='<%$ RouteUrl:routename=Booklets %>' ImageUrl="~/Content/Icons/Back-icon-smaller.png" ToolTip="Tillbaka till listan" runat="server" Text="Tillbaka till listan" />
                            </li>
                            <li>
                                <asp:HyperLink ID="EditHyperLink" CssClass="button" NavigateUrl='<%# GetRouteUrl("BookletEdit", new { id = Item.BookletID }) %>' ImageUrl="~/Content/Icons/Edit-icon-smaller.png" ToolTip="Redigera nothäftet" runat="server" Text="Redigera nothäftet" />
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </ItemTemplate>

    <InsertItemTemplate>
        <div class="row">
        <div class="small-12 large-10 columns booklet-details-card">
            <div class="small-12 columns booklet-details-card-info">
                <div class="row">
                    <label class="small-12 large-10 columns custom-label">
                        Titel:
                        <asp:TextBox ID="nameTextBox" runat="server" Text="<%# BindItem.Name %>" />
                        <%-- Plats för valideringskontroller --%>
                    </label>
                </div>
                <div class="row">
                    <label class="small-12 large-6 columns custom-label">
                        Förlag:
                        <%-- Fixa dropdownboxen --%>
                        <asp:DropDownList ID="publisherDropDownList" runat="server" />
                    </label>
                </div>
                <div class="row">
                    <label class="small-12 large-2 columns custom-label">
                        Utgivningsår:
                        <asp:TextBox ID="yearOfPublicationTextBox" runat="server" Text="<%# BindItem.YearOfPublication.Year %>" />
                        <%-- Plats för valideringskontroller --%>
                    </label>
                </div>
                <div class="row">
                    <label class="small-12 large-2 columns custom-label">
                        Hylla:
                        <asp:TextBox ID="placeTextBox" runat="server" Text="<%# BindItem.Place %>" />
                        <%-- Plats för valideringskontroller --%>
                    </label>
                </div>
            </div>
            <div class="small-12 columns booklet-details-card-pieces">
                <p><span class="custom-label">Innehåll:</span></p>
                <%-- A User Control displaying content of the booklet. --%>
                <uc1:bookletpiecedisplaymanipulate runat="server" ID="BookletPieceDisplayManipulate" BookletID="<%$ RouteValue:id %>" ReadOnly="false" />
            </div>
            <div class="booklet-details-card-other small-12 columns">
                <div class="small-12 medium-9 large-10 columns">
                    <div class="booklet-details-card-other-note small-12 columns">
                        <div class="row">
                            <label class="small-12 large-10 columns custom-label">Anteckningar:
                                <asp:TextBox ID="notesTextBox" runat="server" TextMode="MultiLine" Text="Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus fringilla placerat orci, sed lacinia purus tempus eu. Donec tristique ligula." />
                                <%-- Plats för valideringskontroller --%>
                            </label>
                        </div>
                    </div>
                    <div class="booklet-details-card-other-borrowedTo small-12 columns">
                        <div class="row">
                            <label class="small-12 large-5 columns custom-label">Utlånad till:
                                <asp:TextBox ID="borrowedToTextBox" runat="server" Text="Kompis" />
                                <%-- Plats för valideringskontroller --%>
                            </label>
                        </div>
                    </div>
                </div>
                <div class="booklet-details-card-buttons small-12 medium-3 large-2 columns">
                    <ul class="button-list">
                        <li>
                            <asp:HyperLink ID="CancelHyperLink" CssClass="button" NavigateUrl='<%# GetRouteUrl("BookletDetails", new { id = Item.BookletID }) %>' ImageUrl="~/Content/Icons/Cancel-icon-smaller.png" ToolTip="Avbryt" runat="server" Text="Avbryt" />
                        </li>
                        <li>
                            <asp:LinkButton ID="SaveLinkButton" CssClass="button" ToolTip="Spara" runat="server">
                                <asp:Image ID="SaveImage" ImageUrl="~/Content/Icons/Save-icon-smaller.png" AlternateText="Spara" runat="server" />
                            </asp:LinkButton>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    </InsertItemTemplate>

    <EmptyDataTemplate>
        <p>Inget nothäfte hittades.</p>
    </EmptyDataTemplate>

</asp:FormView>
