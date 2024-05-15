﻿<%@ Control Language="C#" AutoEventWireup="true"  CodeBehind="main.ascx.cs" Inherits="ShopsDefault.AdminTools.UserControls.Products.Products.main" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>

<script type="text/javascript" language="javascript">
    function FcOut() {
        $('#<%= txtProductName.ClientID %>').focusout(function () {
            var str = $('#<%= txtProductName.ClientID %>').val();
            $('#<%= txtTitleWeb.ClientID %>').val(str);
            $('#<%= txtLinkSEO.ClientID %>').val(locdau(str));
        });
    }
    function getLinkImage() {
        $('#<%= fuImage.ClientID %>').change(function () {
            var file = $('#<%= fuImage.ClientID %>')[0].files[0]
            $('#<%= txtImage.ClientID %>').val('/images/UploadImages/san-pham/' + file.name);
        });
    }

    $(document).ready(function () {
        FcOut();
        getLinkImage();
    });
</script>

<style>
    select.form-control option:nth-child(2) {
        display: none;
    }
</style>

<ul class="breadcrumb">
    <li><a href="/AdminTools/BangDieuKhien.html">Bảng điều khiển</a></li>
    <li>Danh sách xe</li>
</ul>


<div class="container-fluid">
    <div class="block-default">
        <div class="block-header">
            <i class="icon-bag"></i>Danh sách xe có sẵn
        </div>
        <div class="block-body">
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div class="btn-groups">
                        <asp:LinkButton ID="btnAdd" runat="server" OnClick="btnAdd_Click" CssClass="btn btn-success add-new"><i class="icon-plus"></i> Thêm</asp:LinkButton>
                    </div>
                    <asp:GridView ID="grv" runat="server" AutoGenerateColumns="False" AllowPaging="True" OnRowDataBound="grv_OnRowDataBound" DataKeyNames="ID_Product" OnRowDeleting="grv_RowDeleting" OnPageIndexChanging="grv_PageIndexChanging" CssClass="table table-default">
                        <PagerStyle CssClass="pagination" />
                        <Columns>
                            <asp:BoundField DataField="ID_Product" HeaderText="ID" HtmlEncode="true" />
                            <asp:BoundField DataField="ProductName" HeaderText="Tên xe" HtmlEncode="true" />
                            <asp:BoundField DataField="CatalogName" HeaderText="Tên nhóm xe" HtmlEncode="true" />
                            <asp:BoundField DataField="ProductCode" HeaderText="Mã xe" HtmlEncode="true" />
                            <asp:BoundField DataField="PriceOut" HeaderText="Giá thuê" HtmlEncode="true" />
                            <asp:BoundField DataField="Color" HeaderText="Màu sắc" HtmlEncode="true" />
                            <asp:BoundField DataField="Amount" HeaderText="Số lượng" HtmlEncode="true" />
                            <asp:BoundField DataField="Weight" HeaderText="Tốc độ" HtmlEncode="true" />
                            <asp:TemplateField HeaderText="Trạng thái" SortExpression="Hidden">
                                <ItemTemplate><%# (Boolean.Parse(Eval("Hidden").ToString())) ? "Kích hoạt" : "Không kích hoạt" %></ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Hành động">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkEdit" runat="server" OnClick="btnEdit_Click" CssClass="btn btn-info"><i class="icon-pencil"></i> Sửa</asp:LinkButton>
                                    <asp:LinkButton ID="lnkDelete" runat="server" CausesValidation="false" CommandName="Delete" CssClass="btn btn-danger"><i class="icon-trash"></i> Xóa </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>

                    <asp:Panel ID="pnlAddEdit" runat="server" CssClass="modalPopup" Style="display: none">
                        <script type="text/javascript" language="javascript">
                            var prm = Sys.WebForms.PageRequestManager.getInstance();

                            prm.add_endRequest(function () {
                                FcOut();
                                getLinkImage();
                            });
                        </script>
                        <div class="popup-body">
                            <div class="card">
                                <div class="card-header">
                                    <i class="icon-note"></i>Thêm xe
                                </div>
                                <div class="card-body scrollbar-y-custom">
                                    <div class="form-group d-none">
                                        <label for="company">ID Xe</label>
                                        <asp:TextBox ID="txtID_Product" runat="server" placeholder="ID Xe" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                    </div>
                                    <div class="row">
                                        <div class="col-6">
                                            <div class="form-group">
                                                <label for="company">Nhóm Xe</label>
                                                <asp:SqlDataSource ID="ds" runat="server" EnableCaching="false"></asp:SqlDataSource>
                                                <asp:DropDownList ID="txtID_Catalog" runat="server" DataSourceID="ds" DataTextField="CatalogName" DataValueField="ID_Catalog" AppendDataBoundItems="true" CssClass="form-control">
                                                    <asp:ListItem Text="Chọn nhóm Xe" Value="0" Selected="true" />
                                                </asp:DropDownList>
                                            </div>
                                            <div class="form-group">
                                                <label for="company">Tên Xe</label>
                                                <asp:TextBox ID="txtProductName" runat="server" placeholder="Nhập tên danh mục" CssClass="form-control"></asp:TextBox>
                                            </div>
                                            <div class="form-group">
                                                <label for="company">Mã Xe</label>
                                                <asp:TextBox ID="txtProductCode" runat="server" placeholder="Nhập mã Xe" CssClass="form-control"></asp:TextBox>
                                            </div>
                                            <div class="form-group">
                                                <label for="company">Giá Xe</label>
                                                <asp:TextBox ID="txtPriceOut" runat="server" placeholder="Nhập giá Xe" CssClass="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-6">                                            
                                            <div class="form-group">
                                                <label for="company">Số lượng</label>
                                                <asp:TextBox ID="txtAmount" runat="server" placeholder="Nhập số lượng" CssClass="form-control"></asp:TextBox>
                                            </div>
                                            <div class="form-group">
                                                <label for="company">Màu sắc</label>
                                                <asp:TextBox ID="txtColor" runat="server" placeholder="Nhập màu Xe" CssClass="form-control"></asp:TextBox>
                                            </div>
                                            <div class="form-group">
                                                <label for="company">Tốc độ</label>
                                                <asp:TextBox ID="txtWeight" runat="server" placeholder="Nhập tốc độ Xe" CssClass="form-control"></asp:TextBox>
                                            </div>
                                            <div class="form-group">
                                                <label for="company">Mô tả</label>
                                                <asp:TextBox ID="txtSummaryContent" runat="server" placeholder="Nhập mô tả Xe" CssClass="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="company">Hình ảnh</label>
                                        <div class="position-relative">
                                            <asp:TextBox ID="txtImage" runat="server" placeholder="Nhập link hình ảnh" CssClass="form-control"></asp:TextBox>
                                            <asp:FileUpload ID="fuImage" runat="server" CssClass="form-control btn-fu" accept=".png,.jpg,.jpeg,.gif" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="street">Nội dung chi tiết</label>
                                        <div class="form-control custom-editor">
                                            <CKEditor:CKEditorControl ID="txtDetail" Language="Vi" BasePath="~/ckeditor" runat="server"></CKEditor:CKEditorControl>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="ContentMain_ctl00_cbHidden">Kích hoạt</label>
                                        <asp:CheckBox ID="cbHidden" runat="server" Style="margin-left: 8px;"></asp:CheckBox>
                                    </div>
                                    <div class="form-group">
                                        <label for="company">Tiêu đề website</label>
                                        <asp:TextBox ID="txtTitleWeb" runat="server" placeholder="Nhập tiêu đề website" CssClass="form-control"></asp:TextBox>
                                    </div>
                                    <div class="form-group">
                                        <label for="country">Đường dẫn website</label>
                                        <asp:TextBox ID="txtLinkSEO" runat="server" placeholder="Nhập đường dẫn website" CssClass="form-control"></asp:TextBox>
                                    </div>

                                    <div class="form-actions">
                                        <asp:LinkButton ID="btnSave" runat="server" OnClick="btnSave_Click" CssClass="btn btn-primary">Lưu</asp:LinkButton>
                                        <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-secondary">Hủy</asp:LinkButton>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                    <asp:LinkButton ID="lnkFake" runat="server"></asp:LinkButton>
                    <cc1:ModalPopupExtender ID="popup" runat="server" DropShadow="false"
                        PopupControlID="pnlAddEdit" TargetControlID="lnkFake"
                        BackgroundCssClass="modalBackground">
                    </cc1:ModalPopupExtender>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="grv" />
                    <asp:AsyncPostBackTrigger ControlID="btnSave" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>
</div>
