<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="BookletDisplayManipulate.ascx.cs" Inherits="MusicLibrary.Pages.Shared.BookletDisplayManipulate" %>

<asp:FormView ID="BookletFormView" runat="server"
    ItemType="MusicLibrary.Model.BLL.Booklet"
    DataKeyNames="BookletID"
    DefaultMode="ReadOnly"
    SelectMethod="BookletFormView_GetItem"
    UpdateMethod="BookletFormView_UpdateItem"
    OnDataBound="BookletFormView_DataBound"
    RenderOuterTable="false">

    <ItemTemplate>
        <%-- This section displays all info in table appSchema.Booklet with the key value in the Url. --%>
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

        <%-- This section displays all Pieces in the booklet, data is fetched from table appSchema.BookletContent and appSchema.Piece. --%>
        <div class="small-12 columns booklet-details-card-pieces">
            <p><span class="custom-label">Innehåll:</span></p>
            <%-- A User Control displaying content of the booklet. --%>
            <site:BookletPieceDisplayManipulate runat="server" ID="BookletPieceDisplayManipulate1" BookletID="<%$ routeValue:id %>" Mode="ReadOnly" />
        </div>

        <%-- This section displays info from tables appSchema.Note and appSchema.BorrowdTo where the key is the same as for the booklet. --%>
        <%-- For the moment no data is fetched from the tables, the fields contains static data. --%>
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

            <%-- This section contains the command buttons for the form. --%>
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

    <EditItemTemplate>
        <%-- In this section the user canedit data in table appSchema.Booklet. --%>
        <div class="small-12 columns booklet-details-card-info">
            <div class="row">
                <label class="small-12 large-10 columns custom-label">
                    Titel:
                    <asp:TextBox ID="nameTextBox" runat="server" CssClass="error" Text="<%# BindItem.Name %>" MaxLength="100" />
                    <%-- Validation controls --%>
                    <asp:RequiredFieldValidator ID="nameRequiredFieldValidator" runat="server" CssClass="error" ErrorMessage="Fältet för titel får inte vara tomt" Text="Tomt fält" ControlToValidate="nameTextBox" SetFocusOnError="True" Display="Dynamic" />
                </label>
            </div>
            <div class="row">
                <label class="small-12 large-6 columns custom-label">
                    Förlag:
                    <asp:DropDownList ID="PublisherDropDownList" runat="server" OnPreRender="PublisherDropDownList_PreRender" />
                    <%-- No validation required. --%>
                </label>
            </div>
            <div class="row">
                <label class="small-12 large-2 columns custom-label">
                    Utgivningsår:
                    <asp:TextBox ID="yearOfPublicationTextBox" CssClass="error" runat="server" Text="<%# BindItem.YearOfPublication.Year %>" MaxLength="4" />
                    <%-- Validation controls --%>
                    <asp:RequiredFieldValidator ID="yearRequiredFieldValidator" runat="server" CssClass="error" Display="Dynamic" ControlToValidate="yearOfPublicationTextBox" SetFocusOnError="True" Text="Tomt fält" ErrorMessage="Fältet för utgivningsår får inte vara tomt" />
                    <asp:RegularExpressionValidator ID="yearRegularExpressionValidator" runat="server" CssClass="error" ErrorMessage="Inmatningen i fältet för utgivningår måste hålla formatet [ÅÅÅÅ]" Display="Dynamic" ControlToValidate="yearOfPublicationTextBox" ValidationExpression="^\d{4}$" Text="Ogiltigt format" />
                    <asp:CustomValidator ID="CheckYearValidator" CssClass="error" runat="server" ErrorMessage="Utgivningsår får inte vara i framtiden." ControlToValidate="yearOfPublicationTextBox" ClientValidationFunction="CheckYear" OnServerValidate="CheckYear" Display="Dynamic" Text="Felaktigt årtal" />
                </label>
            </div>
            <div class="row">
                <label class="small-12 large-2 columns custom-label">
                    Hylla:
                    <asp:TextBox ID="placeTextBox" runat="server" CssClass="error" Text="<%# BindItem.Place %>" MaxLength="6" />
                    <%-- Validation controls --%>
                    <asp:RequiredFieldValidator ID="placeRequiredFieldValidator" runat="server" CssClass="error" ErrorMessage="Fältet för hylla får inte vara tomt" ControlToValidate="placeTextBox" Text="Tomt fält" Display="Dynamic" SetFocusOnError="True" />
                    <asp:RegularExpressionValidator ID="placeRegularExpressionValidator" runat="server" CssClass="error" ErrorMessage="Inmatningen i fältet för hylla måste hålla formatet [AA0000]" Display="Dynamic" Text="Ogiltigt format" ControlToValidate="placeTextBox" ValidationExpression="^[A-Z]{2}\d{4}" />
                </label>
            </div>
        </div>

        <%-- I this section user edit the data in table appShema.BookletContent. --%>
        <div class="small-12 columns booklet-details-card-pieces">
            <p><span class="custom-label">Innehåll:</span></p>
            <%-- A User Control editing the content of the booklet. --%>
            <site:BookletPieceDisplayManipulate runat="server" ID="BookletPieceDisplayManipulate" BookletID="<%$ RouteValue:id %>" Mode="Edit" />
        </div>

        <%-- In this section user edit the data in tables appSchema.Note and appSchema.BorrowedBy --%>
        <%-- For the moment no data is here is editable. for the moment update and insert methods ignore this section. --%>
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

            <%-- This section contains the command buttons for the form. --%>
            <div class="booklet-details-card-buttons small-12 medium-3 large-2 columns">
                <ul class="button-list">
                    <li>
                        <asp:HyperLink ID="CancelHyperLink" CssClass="button" NavigateUrl='<%# GetRouteUrl("BookletDetails", new { id = Item.BookletID }) %>' ImageUrl="~/Content/Icons/Cancel-icon-smaller.png" ToolTip="Avbryt" runat="server" Text="Avbryt" />
                    </li>
                    <li>
                        <asp:LinkButton ID="SaveLinkButton" CssClass="button" CommandName="Update" ToolTip="Spara ändringar" runat="server">
                            <asp:Image ID="SaveImage" ImageUrl="~/Content/Icons/Save-icon-smaller.png" AlternateText="Spara ändringar" runat="server" />
                        </asp:LinkButton>
                    </li>
                </ul>
            </div>
        </div>
    </EditItemTemplate>

    <%-- If no BookletContent where found in table appSchema.BookletContent. --%>
    <EmptyDataTemplate>
        <p>Inget nothäfte hittades.</p>
    </EmptyDataTemplate>

</asp:FormView>
