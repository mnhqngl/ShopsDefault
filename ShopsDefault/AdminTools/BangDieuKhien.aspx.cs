﻿using Librari;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ShopsDefault.AdminTools
{
    public partial class BangDieuKhien : System.Web.UI.Page
    {
        public string LabelsJson { get; set; }
        public string DataJson { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //LoadRevenueStatistics();
                GetMonthlyRevenue();
                LoadBestSellingProducts(DateTime.Now.Year, DateTime.Now.Month);
                Order_Reminder_Load();
                Order_Reminder_Getback_Load();
                Contact_Reminder_Load();
            }
        }
        private void GetMonthlyRevenue()
        {
            int selectedYear = DateTime.Now.Year;

            RevenueStatistics stats = new RevenueStatistics();
            DataTable dt = stats.GetMonthlyRevenue(selectedYear);

            var labels = new List<string>();
            var data = new List<decimal>();

            for (int month = 1; month <= 12; month++)
            {
                labels.Add("Tháng " + month);
                var row = dt.Select("Month = " + month);
                if (row.Length > 0)
                {
                    data.Add(Convert.ToDecimal(row[0]["TotalRevenue"]));
                }
                else
                {
                    data.Add(0);
                }
            }

            LabelsJson = Newtonsoft.Json.JsonConvert.SerializeObject(labels);
            DataJson = Newtonsoft.Json.JsonConvert.SerializeObject(data);
        }

        //private void LoadRevenueStatistics()
        //{
        //    RevenueStatistics stats = new RevenueStatistics();
        //    DataTable dt = stats.GetAllMonthlyRevenues();

        //    // Prepare data for the chart
        //    string[] labels = new string[dt.Rows.Count];
        //    decimal[] data = new decimal[dt.Rows.Count];

        //    for (int i = 0; i < dt.Rows.Count; i++)
        //    {
        //        labels[i] = dt.Rows[i]["Month"] + "/" + dt.Rows[i]["Year"];
        //        data[i] = Convert.ToDecimal(dt.Rows[i]["TotalRevenue"]);
        //    }

        //    // Pass data to the client side
        //    LabelsJson = Newtonsoft.Json.JsonConvert.SerializeObject(labels);
        //    DataJson = Newtonsoft.Json.JsonConvert.SerializeObject(data);
        //}
        private void LoadBestSellingProducts(int year, int month)
        {
            AccessDB db = new AccessDB();
            using (SqlConnection conn = db.get_Conn())
            {
                using (SqlCommand cmd = new SqlCommand("GetBestSellingProductsOfMonth", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Year", year);
                    cmd.Parameters.AddWithValue("@Month", month);

                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            // Sản phẩm bán chạy nhất theo số lượng
                            bestSellingProductByQuantityName.InnerText = reader["ProductName"].ToString();
                            bestSellingProductByQuantityTotalSold.InnerText = reader["TotalAmountSold"].ToString();
                            bestSellingProductByQuantityTotalRevenue.InnerText = reader["TotalRevenue"].ToString() + "₫";
                        }

                        if (reader.NextResult() && reader.Read())
                        {
                            // Sản phẩm bán chạy nhất theo doanh thu
                            bestSellingProductByRevenueName.InnerText = reader["ProductName"].ToString();
                            bestSellingProductByRevenueTotalSold.InnerText = reader["TotalAmountSold"].ToString();
                            bestSellingProductByRevenueTotalRevenue.InnerText = reader["TotalRevenue"].ToString() + "₫";
                        }
                    }
                }
            }
        }
        private void Order_Reminder_Load()
        {
            string linkFile = "~/AdminTools/UserControls/Products/Products/order-reminder.ascx";
            if (File.Exists(Server.MapPath(linkFile)))
            {
                Control ctl_main = LoadControl(linkFile);
                order_reminder_ww.Controls.Add(ctl_main);
            }
        }
        private void Order_Reminder_Getback_Load()
        {
            string linkFile = "~/AdminTools/UserControls/Products/Products/order-reminder-getback.ascx";
            if (File.Exists(Server.MapPath(linkFile)))
            {
                Control ctl_main = LoadControl(linkFile);
                order_reminder_getback_ww.Controls.Add(ctl_main);
            }

        }
        private void Contact_Reminder_Load()
        {
            string linkFile = "~/AdminTools/UserControls/Contact/contact-reminder.ascx";
            if (File.Exists(Server.MapPath(linkFile)))
            {
                Control ctl_main = LoadControl(linkFile);
                contact_reminder_ww.Controls.Add(ctl_main);
            }

        }
    }
}