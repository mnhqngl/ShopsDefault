using System;
using System.Collections.Generic;
using System.Text;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace Librari
{
    public class AccessDB
    {
        public static string sConn = ConfigurationManager.ConnectionStrings["cs_sqlserver"].ToString();

        /// <summary>
        /// Khởi tạo connect
        /// </summary>
        /// <returns></returns>
        public SqlConnection get_Conn()
        {
            try
            {
                return new SqlConnection(sConn);
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        /// <summary>
        /// Thống kê doanh thu theo năm đủ 12 tháng
        /// </summary>
        /// <returns></returns>
        //public DataTable GetMonthlyRevenue(int year)
        //{
        //    using (SqlConnection conn = get_Conn())
        //    {
        //        using (SqlCommand cmd = new SqlCommand("sp_GetMonthlyRevenue", conn))
        //        {
        //            cmd.CommandType = CommandType.StoredProcedure;
        //            cmd.Parameters.AddWithValue("@Year", year);

        //            SqlDataAdapter da = new SqlDataAdapter(cmd);
        //            DataTable dt = new DataTable();
        //            da.Fill(dt);

        //            return dt;
        //        }
        //    }
        //}
    }
}
