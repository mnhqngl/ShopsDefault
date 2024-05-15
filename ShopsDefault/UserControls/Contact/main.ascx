<%@ Control Language="C#" AutoEventWireup="true"  CodeBehind="main.ascx.cs" Inherits="ShopsDefault.UserControls.Contact.main" %>
<style>
    .btn-default {
        margin-bottom: 0;
        margin-top: 0;
    }

    .card-body .form-group label {
        font-weight: 500;
    }

    .block-header.custome-block-header {
        padding-top: 20px;
        margin-bottom: 20px;
        font-size: 25px;
    }

        .block-header.custome-block-header:before {
            bottom: -13px;
        }

        .block-header.custome-block-header:after {
            bottom: -10px;
        }
</style>
<script>
    $(function () {
        $('.btn-contact').click(function (e) {
            if ($('.check-contact-name').val() == '') {
                alert('Nhập tiêu đề để Gửi liên hệ');
                $('.check-contact-name').focus();
                e.preventDefault();
            } else if ($('.check-full-name').val() == '') {
                alert('Nhập họ tên để Gửi liên hệ');
                $('.check-full-name').focus();
                e.preventDefault();
            } else if ($('.check-phone').val() == '') {
                alert('Nhập số điện thoại để Gửi liên hệ');
                $('.check-phone').focus();
                e.preventDefault();
            } else if ($('.check-email').val() == '') {
                alert('Nhập email để Gửi liên hệ');
                $('.check-email').focus();
                e.preventDefault();
            } else if ($('.check-detail').val() == '') {
                alert('Nhập nội dung để Gửi liên hệ');
                $('.check-detail').focus();
                e.preventDefault();
            }
        });
    });
</script>
<div class="contact-default">
    <div class="container">
        <div class="row">
            <div class="col-6">
                <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3723.640805332125!2d105.75986217497639!3d21.047053587150494!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x313454c3ce577141%3A0xb1a1ac92701777bc!2zVHLGsOG7nW5nIMSQ4bqhaSBo4buNYyBUw6BpIG5ndXnDqm4gdsOgIE3DtGkgdHLGsOG7nW5nIEjDoCBO4buZaQ!5e0!3m2!1svi!2s!4v1714150906087!5m2!1svi!2s" width="100%" height="570" frameborder="0" style="border: 0;" allowfullscreen=""></iframe>
            </div>
            <div class="col-6">
                <div class="block-header custome-block-header">Liên hệ với chúng tôi</div>
                <div>
                    <div class="form-group">
                        <label for="company">Tiêu đề</label>
                        <asp:TextBox ID="txtContactName" runat="server" placeholder="Nhập tiêu đề" CssClass="form-control check-contact-name"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="company">Họ và tên</label>
                        <asp:TextBox ID="txtFullName" runat="server" placeholder="Nhập họ tên" CssClass="form-control check-full-name"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="company">Số điện thoại</label>
                        <asp:TextBox ID="txtPhone" runat="server" placeholder="Nhập số điện thoại" CssClass="form-control check-phone"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="company">Địa chỉ email</label>
                        <asp:TextBox ID="txtEmail" runat="server" placeholder="Nhập địa chỉ Email" CssClass="form-control check-email"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="street">Nội dung</label>
                        <asp:TextBox ID="txtDetail" runat="server" TextMode="MultiLine" placeholder="Nhập nội dung" CssClass="form-control check-detail"></asp:TextBox>
                    </div>
                    <div class="form-actions text-center">
                        <asp:LinkButton ID="btnSave" runat="server" OnClick="btnSave_Click" CssClass="btn-default btn-contact" Text="Gửi"></asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

