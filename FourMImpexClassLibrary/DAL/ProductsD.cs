using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Text;


namespace FourMImpexClass.DAL
{
   public class ProductsD
    {
        DBExecution data = new DBExecution();

        //Products ListItems loads  
       /*
        * This function called in Product selection as well as purchase oreder page for both product selections
        * */
        public DataSet LoadListItems(Int64 ProductID, Int64 BrandID, int Action)
        {
            SqlCommand sqlcmd = new SqlCommand();                        
            sqlcmd.Parameters.Add("@ProductID", SqlDbType.BigInt).Value = ProductID;
            sqlcmd.Parameters.Add("@BrandID", SqlDbType.BigInt).Value = BrandID;           
            sqlcmd.Parameters.Add("@Action", SqlDbType.Int).Value = Action;
            sqlcmd.CommandType = CommandType.StoredProcedure;
            sqlcmd.CommandText = "LoadListItems";
            return data.SelectDataFromDB(sqlcmd);
        }

        public DataSet GetStockForModel(Int64 ModelID)
        {
            SqlCommand sqlcmd = new SqlCommand();
            sqlcmd.Parameters.Add("@ModelID", SqlDbType. BigInt).Value = ModelID;
            sqlcmd.CommandType = CommandType.StoredProcedure;
            sqlcmd.CommandText = "GetStockForModel";
            return data.SelectDataFromDB(sqlcmd);
        }

        public DataSet GetAdvanceSearchresults(string SearchText)
        {
            SqlCommand sqlcmd = new SqlCommand();
            sqlcmd.Parameters.Add("@SearchText", SqlDbType.VarChar,100).Value = SearchText;
            sqlcmd.CommandType = CommandType.StoredProcedure;
            sqlcmd.CommandText = "GetAdvanceSearchresults";
            return data.SelectDataFromDB(sqlcmd);
        }

        public DataSet GetDDLCustomers()
        {
            SqlCommand sqlcmd = new SqlCommand();
            sqlcmd.CommandType = CommandType.StoredProcedure;
            sqlcmd.CommandText = "GetDDLCustomers";
            return data.SelectDataFromDB(sqlcmd);
        }

        public DataSet GetDDLCustomers(long CustomerID)
        {
            SqlCommand sqlcmd = new SqlCommand();
            sqlcmd.Parameters.Add("@CustomerID", SqlDbType.BigInt).Value = CustomerID;
            sqlcmd.CommandType = CommandType.StoredProcedure;
            sqlcmd.CommandText = "GetDDLCustomersdetails";
            return data.SelectDataFromDB(sqlcmd);
        }

    }
}
