﻿<%@ Control Language="C#" AutoEventWireup="true"  CodeBehind="cart.old.ascx.cs" Inherits="ShopsDefault.UserControls.Products.cartold" %>

    <div class="prd-cart section">
        <div class="block-header">giỏ đặt xe</div>
        <div class="container">
            <div class="row">
                <div class="col-8">
                    <div class="table-cart">
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="ID_Product" EnableModelValidation="True" OnRowDeleting="GridView1_RowDeleting" OnSelectedIndexChanging="GridView1_SelectedIndexChanging">
                            <Columns>
                                <%--<asp:BoundField DataField="ID_Product" HeaderText="Mã SP">
                                    <HeaderStyle HorizontalAlign="Left" />
                                </asp:BoundField>--%>
                                <%--<asp:BoundField DataField="ProductName">
                                    <HeaderStyle HorizontalAlign="Left" />
                                </asp:BoundField>--%>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <%# Eval("ProductName")%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <div class="prd-amount">
                                            <div class="row">
                                            <div class="col-4"><span class="btn-amount btn_decrement"><i class="fa fa-minus"></i></span><asp:TextBox ID="txtAmount" runat="server" class="addtocart_quantity" type="text" Text='<%# Eval("Amount") %>'></asp:TextBox><span class="btn-amount btn_increment"><i class="fa fa-plus"></i></span></div>
                                            
                                            <div class="col-4 prd-price"><%# Convert.ToDouble(Eval("PriceOut")).ToString("#,##0")%></div>
                                            <div class="col-4 prd-total"><%# Convert.ToDouble(Eval("Total")).ToString("#,##0")%></div>

                                            </div>
                                        </div>
                                    </ItemTemplate>

                                    <%--<EditItemTemplate>
                                        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtQuantity" runat="server" Text='<%# Eval("Amount") %>'></asp:TextBox>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Left" />--%>
                                </asp:TemplateField>
                                <%--<asp:BoundField DataField="PriceOut">
                                    <HeaderStyle HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Total">
                                    <HeaderStyle HorizontalAlign="Left" />
                                </asp:BoundField>--%>
                                <%--<asp:TemplateField HeaderText="Chức Năng">
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButton1" runat="server" CommandName="select">Update</asp:LinkButton>
                                &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CommandName="delete" OnClientClick="return confirm('Are u sure ?')">Delete</asp:LinkButton>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Left" />
                        </asp:TemplateField>--%>
                            </Columns>
                        </asp:GridView>

                    </div>
                </div>
                <div class="col-4">
                </div>
            </div>
        </div>
    </div>
