using System;
using System.Data;
using System.Data.SqlClient;
using Librari;

public class RevenueStatistics
{
    /// <summary>
    /// Thống kê doanh thu đối với các tháng có trong database
    /// </summary>
    /// <returns></returns>
    public DataTable GetAllMonthlyRevenues()
    {
        DataTable dt = new DataTable();
        AccessDB accessDB = new AccessDB();

        using (SqlConnection conn = accessDB.get_Conn())
        {
            using (SqlCommand cmd = new SqlCommand("GetAllMonthlyRevenues", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                SqlDataAdapter da = new SqlDataAdapter(cmd);

                da.Fill(dt);
            }
        }

        return dt;
    }
    public DataTable GetMonthlyRevenue(int year)
    {
        DataTable dt = new DataTable();
        AccessDB accessDB = new AccessDB();

        using (SqlConnection conn = accessDB.get_Conn())
        {
            using (SqlCommand cmd = new SqlCommand("sp_GetMonthlyRevenue", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Year", year);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);

                return dt;
            }
        }
    }
}
