<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="BookletDisplayManipulate.ascx.cs" Inherits="MusicLibrary.Pages.Shared.BookletDisplayManipulate" %>

<asp:FormView ID="BookletFormView" runat="server"
    ItemType="MusicLibrary.Model.BLL.Booklet"
    DataKeyNames="BookletID"
    DefaultMode="ReadOnly"
    SelectMethod="BookletFormView_GetItem"
    OnDataBound="BookletFormView_DataBound"
    RenderOuterTable="false"
    OnInit="BookletFormView_Init">

    <ItemTemplate>
        <div class="small-12 columns booklet-details-card-info">
            <p>
                <span class="custom-label">Titel: </span>
                <asp:Literal ID="nameLiteral" runat="server" Text="<%#: Item.Name %>" />
            </p>
            <p>
                <span class="custom-label">Förlag: </span>
                <asp:Literal ID="publisherLiteral" runat="server" Text="Förlag" />
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
            <site:BookletPieceDisplayManipulate runat="server" id="BookletPieceDisplayManipulate1" BookletID="<%$ routeValue:id %>" />
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
    </ItemTemplate>

    <InsertItemTemplate>
        <%-- Error message --%>
        <asp:ValidationSummary ID="InsertEditBookletValidationSummary" data-alert="data-alert" CssClass="alert-box error" runat="server" ShowModelStateErrors="true" DisplayMode="List" />

        <div class="small-12 columns booklet-details-card-info">
            <div class="row">
                <label class="small-12 large-10 columns custom-label">
                    Titel:
                        <asp:TextBox ID="nameTextBox" runat="server" CssClass="error" Text="<%# BindItem.Name %>" MaxLength="100" />
                    <%-- Plats för valideringskontroller --%>
                    <asp:RequiredFieldValidator ID="nameRequiredFieldValidator" runat="server" CssClass="error" ErrorMessage="Fältet för titel får inte vara tomt" Text="Tomt fält" ControlToValidate="nameTextBox" SetFocusOnError="True" Display="Dynamic" />
                </label>
            </div>
            <div class="row">
                <label class="small-12 large-6 columns custom-label">
                    Förlag:
                        <asp:DropDownList ID="PublisherDropDownList" runat="server" OnLoad="PublisherDropDownList_Load" />
                </label>
            </div>
            <div class="row">
                <label class="small-12 large-2 columns custom-label">
                    Utgivningsår:
                        <asp:TextBox ID="yearOfPublicationTextBox" CssClass="error" runat="server" Text="<%# BindItem.YearOfPublication.Year %>" MaxLength="4" />
                    <%-- Plats för valideringskontroller --%>
                    <asp:RequiredFieldValidator ID="yearRequiredFieldValidator" runat="server" CssClass="error" Display="Dynamic" ControlToValidate="yearOfPublicationTextBox" SetFocusOnError="True" Text="Tomt fält" ErrorMessage="Fältet för utgivningsår får inte vara tomt" />
                    <asp:RegularExpressionValidator ID="yearRegularExpressionValidator" runat="server" CssClass="error" ErrorMessage="Inmatningen i fältet för utgivningår måste hålla formatet [ÅÅÅÅ]" Display="Dynamic" ControlToValidate="yearOfPublicationTextBox" ValidationExpression="^\d{4}$" Text="Ogiltigt format" />
                </label>
            </div>
            <div class="row">
                <label class="small-12 large-2 columns custom-label">
                    Hylla:
                        <asp:TextBox ID="placeTextBox" runat="server" CssClass="error" Text="<%# BindItem.Place %>" MaxLength="6" />
                    <%-- Plats för valideringskontroller --%>
                    <asp:RequiredFieldValidator ID="placeRequiredFieldValidator" runat="server" CssClass="error" ErrorMessage="Fältet för hylla får inte vara tomt" ControlToValidate="placeTextBox" Text="Tomt fält" Display="Dynamic" SetFocusOnError="True" />
                    <asp:RegularExpressionValidator ID="placeRegularExpressionValidator" runat="server" CssClass="error" ErrorMessage="Inmatningen i fältet för hylla måste hålla formatet [AA0000]" Display="Dynamic" Text="Ogiltigt format" ControlToValidate="placeTextBox" ValidationExpression="^[A-Z]{2}\d{4}" />
                </label>
            </div>
        </div>
        <div class="small-12 columns booklet-details-card-pieces">
            <p><span class="custom-label">Innehåll:</span></p>
            <%-- A User Control displaying content of the booklet. --%>
            <site:BookletPieceDisplayManipulate runat="server" ID="BookletPieceDisplayManipulate" BookletID="<%$ RouteValue:id %>" ReadOnly="false" />
        </div>
        <div class="booklet-details-card-other small-12 columns">
            <div class="small-12 medium-9 large-10 columns">
                <div class="booklet-details-card-other-note small-12 columns">
                    <div class="row">
                        <label class="small-12 large-10 columns custom-label">
                            Anteckningar:
                                <asp:TextBox ID="notesTextBox" runat="server" MaxLength="400" TextMode="MultiLine" Text="Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus fringilla placerat orci, sed lacinia purus tempus eu. Donec tristique ligula." />
                            <%-- No validation required. --%>
                        </label>
                    </div>
                </div>
                <div class="booklet-details-card-other-borrowedTo small-12 columns">
                    <div class="row">
                        <label class="small-12 large-5 columns custom-label">
                            Utlånad till:
                                <asp:TextBox ID="borrowedToTextBox" MaxLength="40" runat="server" Text="Kompis" />
                            <%-- No validation required. --%>
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
                        <asp:LinkButton ID="SaveLinkButton" CssClass="button" ToolTip="Spara nothäfte" runat="server">
                            <asp:Image ID="SaveImage" ImageUrl="~/Content/Icons/Save-icon-smaller.png" AlternateText="Spara nothäfte" runat="server" />
                        </asp:LinkButton>
                    </li>
                </ul>
            </div>
        </div>
    </InsertItemTemplate>

    <EmptyDataTemplate>
        <p>Inget nothäfte hittades.</p>
    </EmptyDataTemplate>

</asp:FormView>
