using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace FourMImpexClass.DAL
{
   public  class ReportsD
    {
        DBExecution data = new DBExecution();
        public DataSet GetCurrentStockReport(string searchtext, byte flag)
        {
            SqlCommand sqlcmd = new SqlCommand();            
            sqlcmd.Parameters.Add(new SqlParameter("@SearchText", SqlDbType.VarChar, 50)).Value = searchtext;
            sqlcmd.Parameters.Add(new SqlParameter("@Flag", SqlDbType.TinyInt)).Value = flag;
            sqlcmd.CommandType = CommandType.StoredProcedure;
            sqlcmd.CommandText = "GetCurrentStockReport";
            return data.SelectDataFromDB(sqlcmd);
        }

        public DataSet GetCurrentStockForBarcodeGeneration(string searchtext, byte flag)
        {
            SqlCommand sqlcmd = new SqlCommand();
            sqlcmd.Parameters.Add(new SqlParameter("@SearchText", SqlDbType.VarChar, 50)).Value = searchtext;
            sqlcmd.Parameters.Add(new SqlParameter("@Flag", SqlDbType.TinyInt)).Value = flag;
            sqlcmd.CommandType = CommandType.StoredProcedure;
            sqlcmd.CommandText = "GetCurrentStockForBarcodeGeneration";
            return data.SelectDataFromDB(sqlcmd);
        }

        public DataSet rptPurchaseOrder(string txtfrom, string txtto, string searchtext, int flag)
        {
            SqlCommand sqlcmd = new SqlCommand();
            sqlcmd.Parameters.Add(new SqlParameter("@txtfrom", SqlDbType.VarChar, 20)).Value = txtfrom;
            sqlcmd.Parameters.Add(new SqlParameter("@txtto", SqlDbType.VarChar, 20)).Value = txtto;
            sqlcmd.Parameters.Add(new SqlParameter("@SearchText", SqlDbType.VarChar, 50)).Value = searchtext;
            sqlcmd.Parameters.Add(new SqlParameter("@Flag", SqlDbType.Int)).Value = flag;
            sqlcmd.CommandType = CommandType.StoredProcedure;
            sqlcmd.CommandText = "rptPurchaseOrder";
            return data.SelectDataFromDB(sqlcmd);
        }
        public DataSet rptRecipt(string txtfrom, string txtto, string searchtext, int flag)
        {
            SqlCommand sqlcmd = new SqlCommand();
            sqlcmd.Parameters.Add(new SqlParameter("@txtfrom", SqlDbType.VarChar, 20)).Value = txtfrom;
            sqlcmd.Parameters.Add(new SqlParameter("@txtto", SqlDbType.VarChar, 20)).Value = txtto;
            sqlcmd.Parameters.Add(new SqlParameter("@SearchText", SqlDbType.VarChar, 50)).Value = searchtext;
            sqlcmd.Parameters.Add(new SqlParameter("@Flag", SqlDbType.Int)).Value = flag;
            sqlcmd.CommandType = CommandType.StoredProcedure;
            sqlcmd.CommandText = "rptRecipt";
            return data.SelectDataFromDB(sqlcmd);
        }
        public DataSet rptSalesReceipt(string txtfrom, string txtto, string searchtext, int flag)
        {
            SqlCommand sqlcmd = new SqlCommand();
            sqlcmd.Parameters.Add(new SqlParameter("@txtfrom", SqlDbType.VarChar, 20)).Value = txtfrom;
            sqlcmd.Parameters.Add(new SqlParameter("@txtto", SqlDbType.VarChar, 20)).Value = txtto;
            sqlcmd.Parameters.Add(new SqlParameter("@SearchText", SqlDbType.VarChar, 50)).Value = searchtext;
            sqlcmd.Parameters.Add(new SqlParameter("@Flag", SqlDbType.Int)).Value = flag;
            sqlcmd.CommandType = CommandType.StoredProcedure;
            sqlcmd.CommandText = "rptCurrentStock";
            return data.SelectDataFromDB(sqlcmd);
        }
    }
}
