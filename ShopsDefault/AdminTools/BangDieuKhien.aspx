<%@ Page Title="" Language="C#" MasterPageFile="~/AdminTools/AdminTools.Master" AutoEventWireup="true" CodeBehind="BangDieuKhien.aspx.cs" Inherits="ShopsDefault.AdminTools.BangDieuKhien" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    <title>XeXpress - Bảng điều khiển</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="css" runat="server">
    <style>
        #revenueChart {
            max-height: 450px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Header" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Banner_Slider" runat="server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="Left" runat="server">
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="ContentMain" runat="server">
    <div class="main">
        <ul class="breadcrumb">
            <li>Bảng điều khiển</li>
        </ul>
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <div class="block-default my-md-3">
                        <div class="block-header">
                            <i class="icon-chart"></i>Doanh thu hàng tháng - Năm <%= DateTime.Now.Year %>
                        </div>
                        <div class="block-body">
                            <canvas id="revenueChart"></canvas>
                        </div>
                    </div>
                </div>
            <div class="col-12">
                <div class="block-default">
                    <div class="block-header">
                        <i class="icon-bag"></i>Danh sách đơn thuê xe ngày mai
                    </div>
                    <div class="block-body">
                        <div id="order_reminder_ww" runat="server">
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-12">
                <div class="block-default my-md-3">
                    <div class="block-header">
                        <i class="icon-bag"></i>Danh sách đơn thuê xe tới ngày trả
                    </div>
                    <div class="block-body">
                        <div id="order_reminder_getback_ww" runat="server">
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-12">
                <div class="block-default">
                    <div class="block-header">
                        <i class="icon-bubble"></i>Khách hàng liên hệ gần đây
                    </div>
                    <div class="block-body">
                        <div id="contact_reminder_ww" runat="server">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>
</asp:Content>
<asp:Content ID="Content7" ContentPlaceHolderID="Right" runat="server">
</asp:Content>
<asp:Content ID="Content8" ContentPlaceHolderID="Footer" runat="server">
</asp:Content>
<asp:Content ID="Content9" ContentPlaceHolderID="js" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            var ctx = document.getElementById('revenueChart').getContext('2d');
            var labels = <%= LabelsJson %>;
            var data = <%= DataJson %>;

            var chart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Doanh thu hàng tháng',
                        data: data,
                        backgroundColor: 'rgba(75, 192, 192, 0.6)',
                        borderColor: 'rgba(75, 192, 192, 1)',
                        hoverBackgroundColor: 'rgb(34, 131, 220, 0.8)',
                        hoverBorderColor: 'blue',
                        borderWidth: 1,
                        fill: false
                    }]
                },
                options: {
                    scales: {
                        x: {
                            ticks: {
                                color: 'white',
                            }
                        },
                        y: {
                            beginAtZero: true,
                            ticks: {
                                callback: function (value) {
                                    return value.toLocaleString() + "₫"; // Format the value with commas and add "Đồng"
                                },
                                color: 'white',
                            }
                        }
                    },
                    plugins: {
                        tooltip: {
                            callbacks: {
                                label: function (context) {
                                    var label = context.dataset.label || '';
                                    if (label) {
                                        label += ': ';
                                    }
                                    label += context.raw.toLocaleString() + '₫';
                                    return label;
                                }
                            }
                        },
                        legend: {
                            display: true,
                            labels: {
                                color: 'rgba(255, 255, 255, 0.9)',
                                font: {
                                    size: 14
                                }
                            }
                        }
                    }
                }
            });
        });
    </script>
</asp:Content>
