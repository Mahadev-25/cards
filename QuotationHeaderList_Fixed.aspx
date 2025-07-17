<%@ Page Theme="Enterprise" MasterPageFile="~/masterpages/Enterprise.master" Language="VB" AutoEventWireup="true" CodeFile="QuotationHeaderList.aspx.vb" Inherits="QuotationHeaderList" %>

<%@ Register Assembly="EnterpriseASPClient" Namespace="EnterpriseASPClient.Core" TagPrefix="core" %>

<%@ Register Assembly="EnterpriseASPClient" Namespace="EnterpriseASPClient.Controls" TagPrefix="ctls" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="_header">
    <asp:Label ID="lblPageHeader" runat="server" SkinID="headerSkin" Text="<%$ Translation:Quotations List %>"></asp:Label>
</asp:Content>

<asp:Content ID="PageContent" runat="server" ContentPlaceHolderID="_mainContent">
    <!-- Enhanced CSS and JS Libraries -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Custom Enhanced Styles -->
    <style>
        /* Modern Page Layout */
        .quotation-container {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px 0;
        }

        .main-content {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            padding: 30px;
            margin: 20px auto;
            max-width: 98%;
            backdrop-filter: blur(10px);
        }

        /* Header Styles */
        .page-header {
            background: linear-gradient(135deg, #ff6b6b, #ee5a24);
            color: white;
            padding: 25px;
            border-radius: 15px;
            margin-bottom: 30px;
            text-align: center;
            box-shadow: 0 10px 30px rgba(238, 90, 36, 0.3);
        }

        .page-header h1 {
            margin: 0;
            font-size: 2.5rem;
            font-weight: 600;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        }

        /* Action Panel Enhanced */
        .action-panel {
            background: linear-gradient(135deg, #74b9ff, #0984e3);
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 25px;
            box-shadow: 0 8px 25px rgba(116, 185, 255, 0.3);
        }

        .action-panel .btn-group button {
            margin: 5px;
            border-radius: 10px;
            padding: 12px 20px;
            font-weight: 500;
            transition: all 0.3s ease;
            border: none;
        }

        .training-video-btn {
            background: linear-gradient(135deg, #ff3838, #ff6b6b);
            color: white;
            box-shadow: 0 5px 15px rgba(255, 56, 56, 0.4);
        }

        .training-video-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(255, 56, 56, 0.6);
        }

        /* Modal Dialogs Enhanced */
        .modal-dialog-custom {
            background: linear-gradient(135deg, #ffffff, #f8f9fa);
            border-radius: 20px;
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.2);
            border: none;
            backdrop-filter: blur(15px);
            animation: fadeInDown 0.5s ease-out;
        }

        .modal-header-custom {
            background: linear-gradient(135deg, #6c5ce7, #a29bfe);
            color: white;
            border-radius: 20px 20px 0 0;
            padding: 20px;
            text-align: center;
        }

        .modal-body-custom {
            padding: 25px;
        }

        .modal-footer-custom {
            padding: 20px;
            border-top: none;
            justify-content: center;
        }

        .btnClose {
            background: linear-gradient(135deg, #ff6b6b, #ee5a24);
            color: white;
            border: none;
            border-radius: 10px;
            padding: 12px 25px;
            font-size: 16px;
            font-weight: 500;
            margin: 0 8px;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(238, 90, 36, 0.3);
        }

        .btnClose:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(238, 90, 36, 0.5);
        }

        .btnClose.cancel {
            background: linear-gradient(135deg, #636e72, #2d3436);
        }

        /* Grid View Enhanced */
        .grid-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            margin-top: 20px;
        }

        #OrderHeaderGrid {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        #OrderHeaderGrid th {
            background: linear-gradient(135deg, #2d3436, #636e72);
            color: white;
            padding: 15px 10px;
            font-weight: 600;
            text-align: center;
            font-size: 14px;
            border: none;
            position: sticky;
            top: 0;
            z-index: 10;
        }

        #OrderHeaderGrid td {
            padding: 12px 10px;
            border-bottom: 1px solid #e9ecef;
            vertical-align: middle;
            transition: all 0.3s ease;
        }

        #OrderHeaderGrid tr:hover td {
            background-color: #f8f9fa;
            transform: scale(1.01);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        #OrderHeaderGrid tr:nth-child(even) {
            background-color: #f8f9fa;
        }

        /* Enhanced ChildLink styling */
        #OrderHeaderGrid a img {
            width: 24px;
            height: 24px;
            border-radius: 50%;
            padding: 6px;
            transition: all 0.3s ease;
            border: 2px solid transparent;
        }

        /* Specific styling for different action types */
        #OrderHeaderGrid td:nth-child(1) a img { /* Edit */
            background: linear-gradient(135deg, #00b894, #00a085);
            border-color: #00b894;
        }

        #OrderHeaderGrid td:nth-child(3) a img { /* Attachment */
            background: linear-gradient(135deg, #6c5ce7, #a29bfe);
            border-color: #6c5ce7;
        }

        #OrderHeaderGrid td:nth-child(4) a img, /* Print SQ */
        #OrderHeaderGrid td:nth-child(5) a img, /* Print Specs */
        #OrderHeaderGrid td:nth-child(6) a img { /* Stock */
            background: linear-gradient(135deg, #74b9ff, #0984e3);
            border-color: #74b9ff;
        }

        #OrderHeaderGrid td:nth-child(7) a img { /* Follow up */
            background: linear-gradient(135deg, #fdcb6e, #f39c12);
            border-color: #fdcb6e;
        }

        #OrderHeaderGrid td:nth-child(8) a img { /* WhatsApp */
            background: linear-gradient(135deg, #00b894, #25D366);
            border-color: #25D366;
        }

        #OrderHeaderGrid a:hover img {
            transform: translateY(-3px) scale(1.1);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
        }

        /* Action Button Icons Enhanced */
        .action-btn {
            width: 35px;
            height: 35px;
            border-radius: 50%;
            border: none;
            margin: 2px;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
        }

        .action-btn::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            background: rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            transform: translate(-50%, -50%);
            transition: all 0.3s ease;
        }

        .action-btn:hover::before {
            width: 100%;
            height: 100%;
        }

        .action-btn:hover {
            transform: translateY(-3px) scale(1.1);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
        }

        .edit-btn {
            background: linear-gradient(135deg, #00b894, #00a085);
            color: white;
        }

        .revise-btn {
            background: linear-gradient(135deg, #fdcb6e, #e17055);
            color: white;
        }

        .order-btn {
            background: linear-gradient(135deg, #00b894, #55efc4);
            color: white;
        }

        .close-btn {
            background: linear-gradient(135deg, #ff7675, #d63031);
            color: white;
        }

        .copy-btn {
            background: linear-gradient(135deg, #a29bfe, #6c5ce7);
            color: white;
        }

        .ticket-btn {
            background: linear-gradient(135deg, #ffeaa7, #fdcb6e);
            color: #2d3436;
            font-size: 12px;
            font-weight: bold;
        }

        /* Search Panel Enhanced */
        .search-panel {
            background: linear-gradient(135deg, #dfe6e9, #b2bec3);
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }

        /* Form Controls Enhanced */
        .form-control, .form-select {
            border-radius: 10px;
            border: 2px solid #e9ecef;
            padding: 12px 15px;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: #74b9ff;
            box-shadow: 0 0 0 0.2rem rgba(116, 185, 255, 0.25);
            transform: translateY(-2px);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .main-content {
                margin: 10px;
                padding: 15px;
            }

            .page-header h1 {
                font-size: 1.8rem;
            }

            .action-btn {
                width: 30px;
                height: 30px;
            }

            #OrderHeaderGrid {
                font-size: 12px;
            }

            #OrderHeaderGrid th,
            #OrderHeaderGrid td {
                padding: 8px 5px;
            }

            #OrderHeaderGrid a img {
                width: 20px;
                height: 20px;
            }
        }

        @media (max-width: 576px) {
            .grid-container {
                overflow-x: auto;
            }

            #OrderHeaderGrid {
                min-width: 800px;
            }
        }

        /* Animation Keyframes */
        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translate3d(0, -100%, 0);
            }
            to {
                opacity: 1;
                transform: translate3d(0, 0, 0);
            }
        }

        /* Action Panel Button Styling */
        .btn-primary-custom {
            background: linear-gradient(135deg, #74b9ff, #0984e3);
            border: none;
            border-radius: 10px;
            padding: 12px 20px;
            color: white;
            font-weight: 500;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(116, 185, 255, 0.3);
        }

        .btn-primary-custom:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(116, 185, 255, 0.5);
        }

        /* Tooltip Enhancement */
        [title] {
            position: relative;
        }

        [title]:hover::after {
            content: attr(title);
            position: absolute;
            bottom: 100%;
            left: 50%;
            transform: translateX(-50%);
            background: rgba(0, 0, 0, 0.9);
            color: white;
            padding: 8px 12px;
            border-radius: 6px;
            white-space: nowrap;
            font-size: 12px;
            z-index: 1000;
            animation: fadeInDown 0.3s ease;
        }
    </style>

    <script type="text/javascript" language="javascript">
        function CALL_WINDOW(but_id, linenumber) {
            var targeturl = 'QuotationFollowup.aspx?issuenumber=' + linenumber + '&but_id=' + but_id;
            var win = window.open(targeturl, "UOM2", 'scrollbars,fullscreen=yes');
            if (win.opener == null) win.opender = self;
        }

        // Enhanced UI interactions
        $(document).ready(function() {
            // Add smooth animations to grid rows
            $('#OrderHeaderGrid tr').each(function(index) {
                $(this).css('animation-delay', (index * 50) + 'ms');
                $(this).addClass('animate__animated animate__fadeInUp');
            });

            // Enhanced hover effects for action buttons
            $('.action-btn').hover(
                function() {
                    $(this).addClass('animate__animated animate__pulse');
                },
                function() {
                    $(this).removeClass('animate__animated animate__pulse');
                }
            );
        });
    </script>

    <div class="quotation-container">
        <div class="main-content">
            <!-- Page Header -->
            <div class="page-header">
                <h1><i class="fas fa-file-invoice-dollar me-3"></i>Quotations Management</h1>
                <p class="mb-0">Manage and track all your quotations efficiently</p>
            </div>

            <!-- Modal Dialogs with Enhanced Styling -->
            <div id="Close" runat="server" class="modal-dialog-custom" style="width: 400px; height: auto; position: absolute; top: 50%; left: 50%; margin-top: -150px; margin-left: -200px; display: none;">
                <div class="modal-header-custom">
                    <h3><i class="fas fa-times-circle me-2"></i>Close Reason For
                        <asp:Label ID="lblCloseOrderNumber" runat="server"></asp:Label></h3>
                </div>
                <div class="modal-body-custom">
                    <asp:TextBox ID="txtCLoseDetail" CssClass="form-control" placeholder="Enter close reason..." Width="100%" TextMode="MultiLine" runat="server"></asp:TextBox>
                </div>
                <div class="modal-footer-custom">
                    <asp:Button ID="btnClose" CssClass="btnClose" runat="server" OnClick="btnClose_Click" Text="Close"></asp:Button>
                    <asp:Label ID="lblCloseStatus" runat="server"></asp:Label>
                    <asp:Button ID="btnCloseCancel" CssClass="btnClose cancel" runat="server" OnClick="btnCloseCancel_Click" Text="Cancel"></asp:Button>
                </div>
            </div>

            <div id="ConvertOrder" runat="server" class="modal-dialog-custom" style="width: 400px; height: auto; position: absolute; top: 50%; left: 50%; margin-top: -150px; margin-left: -200px; display: none;">
                <div class="modal-header-custom">
                    <h3><i class="fas fa-exchange-alt me-2"></i>Convert to Order</h3>
                    <asp:Label ID="lblOrderNoForConvertion" runat="server"></asp:Label>
                    <asp:Label ID="lblRevisionNoForConvertion" runat="server" Visible="false"></asp:Label>
                </div>
                <div class="modal-body-custom">
                    <h4><i class="fas fa-calendar-alt me-2"></i>Delivery Date</h4>
                    <asp:TextBox ID="txtDeliveryDate" CssClass="form-control" TextMode="Date" runat="server"></asp:TextBox>
                </div>
                <div class="modal-footer-custom">
                    <asp:Button ID="btnOrderClose" CssClass="btnClose" runat="server" OnClick="btnOrderClose_Click" Text="Convert"></asp:Button>
                    <asp:Button ID="btnOrderCloseNo" CssClass="btnClose cancel" runat="server" OnClick="btnOrderCloseNo_Click" Text="Cancel"></asp:Button>
                </div>
            </div>

            <div id="CopyQuotation" runat="server" class="modal-dialog-custom" style="width: 400px; height: auto; position: absolute; top: 50%; left: 50%; margin-top: -150px; margin-left: -200px; display: none;">
                <div class="modal-header-custom">
                    <h3><i class="fas fa-copy me-2"></i>Copy Quotation</h3>
                    <asp:Label ID="lblOrderNoForCopy" runat="server"></asp:Label>
                    <asp:Label ID="lblReviseNoForCopy" runat="server" Visible="false"></asp:Label>
                </div>
                <div class="modal-body-custom">
                    <h4>Are You Sure? You Want To Copy Quotation</h4>
                </div>
                <div class="modal-footer-custom">
                    <asp:Button ID="btnCopyOk" CssClass="btnClose" runat="server" OnClick="btnCopyOk_Click" Text="Yes"></asp:Button>
                    <asp:Button ID="btnCopyCancel" CssClass="btnClose cancel" runat="server" OnClick="btnCopyCancel_Click" Text="No"></asp:Button>
                </div>
            </div>

            <div id="ReviseQuotation" runat="server" class="modal-dialog-custom" style="width: 400px; height: auto; position: absolute; top: 50%; left: 50%; margin-top: -200px; margin-left: -200px; display: none;">
                <div class="modal-header-custom">
                    <h3><i class="fas fa-edit me-2"></i>Revise Quotation</h3>
                    <asp:Label ID="lblOrderNoForRevision" runat="server"></asp:Label>
                    <asp:Label ID="lblRevisedNoForRevision" runat="server"></asp:Label>
                </div>
                <div class="modal-body-custom">
                    <asp:TextBox ID="txtRevisionReason" CssClass="form-control" placeholder="Enter revision reason..." runat="server" TextMode="MultiLine" Height="150px" Width="100%"></asp:TextBox>
                </div>
                <div class="modal-footer-custom">
                    <asp:Button ID="btnReviseOk" CssClass="btnClose" runat="server" OnClick="btnReviseOk_Click" Text="Yes"></asp:Button>
                    <asp:Button ID="btnReviseCancel" CssClass="btnClose cancel" runat="server" OnClick="btnReviseCancel_Click" Text="No"></asp:Button>
                </div>
            </div>

            <core:DBDataSource ID="DBDataSource1" runat="server" ObjectName="QuotationHeader" TableName="QuotationHeader" />

            <core:ClientCallbackControl ID="ClientCallbackControl1" runat="server">
                <Callbacks>
                    <core:CallbackLink Source="btnMainShowSearch" DataFieldSource="" DataFieldTarget="" DataViewTarget="" Target="MainSearchPanel" />
                </Callbacks>
            </core:ClientCallbackControl>

            <!-- Action Panel -->
            <div class="action-panel">
                <asp:Table runat="server" ID="tblMain" Width="100%">
                    <asp:TableRow>
                        <asp:TableCell>
                            <div class="btn-group">
                                <button type="button" class="training-video-btn" data-bs-toggle="dropdown">
                                    <i class="fab fa-youtube me-2"></i>Training Video
                                </button>
                                <div class="dropdown-menu">
                                    <a class="dropdown-item" href="#" onclick="window.open('https://www.prosyssoftech.com/TrainingVideos/QUOTATIONS.mp4', '_blank'); return false;">
                                        <i class="fas fa-play-circle me-2"></i>Create Quotation
                                    </a>
                                </div>
                            </div>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="Right">
                            <ctls:ShowSearchButton ID="btnMainShowSearch" runat="server" SearchPanelID="MainSearchPanel" Text="Show Search" CssClass="btn-primary-custom me-2" />
                            <ctls:ChildLink ID="btnNewMain" runat="server" DataSourceID="DBDataSource1" TargetTable="QuotationHeader"
                                TargetUrl="QuotationHeaderDetail.aspx" Text="<%$ Translation:New %>" CssClass="btn-primary-custom" />
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </div>

            <!-- Search Panel -->
            <div class="search-panel">
                <ctls:SearchPanel ID="MainSearchPanel" runat="server" GridID="OrderHeaderGrid" SearchButtonText="<%$ Translation:Search %>"
                    ClearButtonText="<%$ Translation:Clear %>" ExpressionLabel="<%$ Translation:Search Expression %>" Visible="False" />
            </div>

            <!-- Grid Container -->
            <div class="grid-container">
                <asp:GridView ID="OrderHeaderGrid" runat="server" DataMember="QuotationHeader" OnRowDataBound="OrderHeaderGrid_RowDataBound" DataSourceID="DBDataSource1"
                    AutoGenerateColumns="False" DataKeyNames="CompanyID,DivisionID,DepartmentID,OrderNumber,RevisedNumber" OnRowCommand="DBDataSource1.HandleGridCommand"
                    CssClass="table table-hover">

                    <Columns>
                        <ctls:ChildLinkField ImageUrl="~/images/edit.gif" TargetUrl="QuotationHeaderDetail.aspx" HeaderText="Edit">
                            <ItemStyle Width="50px" HorizontalAlign="Center" />
                        </ctls:ChildLinkField>

                        <asp:TemplateField HeaderText="Revise" ShowHeader="False" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="50px">
                            <ItemTemplate>
                                <asp:ImageButton ID="btnReviseQuotation" CssClass="action-btn revise-btn" Width="35px" Height="35px" title="Revise Quotation"
                                    ImageUrl="~/images/post.gif" CommandArgument='<%# Eval("OrderNumber").ToString() + "," + Eval("RevisedNumber").ToString()%>' 
                                    OnCommand="btnReviseQuotation_Command" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <ctls:ChildLinkField ImageUrl="~/images/return.gif" TargetUrl='../../SqlServerReports/QuotationFileAttachemnt.aspx' Target="_blank" HeaderText="Attach">
                            <ItemStyle Width="50px" HorizontalAlign="Center" />
                        </ctls:ChildLinkField>

                        <ctls:ChildLinkField ImageUrl="~/images/print.gif" TargetUrl='../../reports/DocQuotation.aspx' HeaderText="SQ" Target="_blank">
                            <ItemStyle Width="50px" HorizontalAlign="Center" />
                        </ctls:ChildLinkField>

                        <ctls:ChildLinkField ImageUrl="~/images/print.gif" TargetUrl='../../reports/DocQuotationSpecs.aspx' HeaderText="SQ Specs" Target="_blank">
                            <ItemStyle Width="50px" HorizontalAlign="Center" />
                        </ctls:ChildLinkField>

                        <ctls:ChildLinkField ImageUrl="~/images/print.gif" HeaderText="Stock" TargetUrl='../../NewASPXReports/NewQuotationAndOrderStockReport.aspx?Type=Quotation' Target="_blank">
                            <ItemStyle Width="50px" HorizontalAlign="Center" />
                        </ctls:ChildLinkField>

                        <ctls:ChildLinkField ImageUrl="~/images/followup.png" HeaderText="Update" TargetUrl='QuotationFollowup.aspx' Target="_blank">
                            <ItemStyle Width="50px" HorizontalAlign="Center" />
                        </ctls:ChildLinkField>

                        <ctls:ChildLinkField ImageUrl="~/images/Whatsapp.png" TargetUrl='WhatsappForQuot.aspx' HeaderText="W.A" Target="_blank">
                            <ItemStyle Width="50px" HorizontalAlign="Center" />
                        </ctls:ChildLinkField>

                        <asp:BoundField HeaderText="<%$ Translation:Quotation No %>" DataField="OrderNumber" SortExpression="OrderNumber" ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField HeaderText="<%$ Translation:Revision %>" DataField="RevisedNumber" SortExpression="RevisedNumber" ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField HeaderText="<%$ Translation:Stage %>" DataField="StageID" SortExpression="StageID" ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField HeaderText="<%$ Translation:Date %>" DataField="OrderDate" SortExpression="OrderDate" DataFormatString="{0:d}" HtmlEncode="false" ApplyFormatInEditMode="true" ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField HeaderText="<%$ Translation:Customer Name %>" DataField="ShippingName" SortExpression="ShippingName" ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField HeaderText="<%$ Translation:Customer Enquiry No %>" DataField="CustomerPONo" SortExpression="CustomerPONo" ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField HeaderText="<%$ Translation:Employee %>" DataField="EmployeeID" SortExpression="EmployeeID" ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField HeaderText="<%$ Translation:Total %>" DataField="Total" SortExpression="Total" DataFormatString="{0:n}" HtmlEncode="false" ApplyFormatInEditMode="true" ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField HeaderText="<%$ Translation:Next Followup %>" DataField="NextFollowUp" SortExpression="NextFollowUp" DataFormatString="{0:d}" HtmlEncode="false" ApplyFormatInEditMode="true" ItemStyle-HorizontalAlign="Center" />

                        <asp:TemplateField HeaderText="Order" ShowHeader="False" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="50px">
                            <ItemTemplate>
                                <asp:ImageButton ID="btnConvertToOrder" CssClass="action-btn order-btn" Width="35px" Height="35px" title="Convert to Order"
                                    ImageUrl="~/images/createcontract.gif" CommandArgument='<%# Eval("OrderNumber").ToString() + "," + Eval("RevisedNumber").ToString()%>' 
                                    OnCommand="btnConvertToOrder_Command" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Close" ShowHeader="False" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="50px">
                            <ItemTemplate>
                                <asp:ImageButton ID="btnClose" CssClass="action-btn close-btn" Width="35px" Height="35px" title="Close Quotation"
                                    ImageUrl="~/images/Close.png" CommandArgument='<%# eval("OrderNumber") %>' OnCommand="btnClose_Command" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Copy" ShowHeader="False" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="50px">
                            <ItemTemplate>
                                <asp:ImageButton ID="btnCopyQuotation" CssClass="action-btn copy-btn" Width="35px" Height="35px" title="Copy Quotation"
                                    ImageUrl="~/images/Copy.ico" CommandArgument='<%# Eval("OrderNumber").ToString() + "," + Eval("RevisedNumber").ToString()%>' 
                                    OnCommand="btnCopyQuotation_Command" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="For Approval" ShowHeader="False" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="50px" Visible="false">
                            <ItemTemplate>
                                <asp:ImageButton ID="btnApproval" CssClass="action-btn" Width="35px" Height="35px" title="Send for Approval"
                                    ImageUrl="~/images/Close.png" CommandArgument='<%# Eval("OrderNumber") %>' OnCommand="btnApproval_Command" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="T & S" ShowHeader="False" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px">
                            <ItemTemplate>
                                <asp:Button ID="btnTicketAndSelect" runat="server" CssClass="action-btn ticket-btn" title="Tick & Select"
                                    Text="T&S" CommandArgument='<%# Eval("OrderNumber").ToString() + "," + Eval("RevisedNumber").ToString()%>' 
                                    OnClick="btnTicketAndSelect_Click" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>

            <!-- Action Panel Footer -->
            <div class="action-panel mt-4">
                <ctls:ActionPanel ID="ActionPanel1" runat="server" DataSourceID="DBDataSource1" />
            </div>
        </div>
    </div>

</asp:Content>