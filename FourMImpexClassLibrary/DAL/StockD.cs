using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Data.OleDb;

namespace FourMImpexClass.DAL
{
   public class StockD
    {
        DBExecution data = new DBExecution();
        public DataSet OpenStockLoaddata(Byte FilterType, String FilterText)
        {
            SqlCommand sqlcmd = new SqlCommand();            
            sqlcmd.CommandType = CommandType.StoredProcedure;
            sqlcmd.Parameters.Add("@FilterType", SqlDbType.TinyInt).Value = FilterType;
            sqlcmd.Parameters.Add("@FilterText", SqlDbType.VarChar, 100).Value = FilterText;  
            sqlcmd.CommandText = "LoadOpenStockData";
            return data.SelectDataFromDB(sqlcmd);
        }

        public DataSet GetOpenStockTemplate(string searchtext, byte flag)
        {
            SqlCommand sqlcmd = new SqlCommand();
            sqlcmd.Parameters.Add(new SqlParameter("@SearchText", SqlDbType.VarChar, 50)).Value = searchtext;
            sqlcmd.Parameters.Add(new SqlParameter("@Flag", SqlDbType.TinyInt)).Value = flag;
            sqlcmd.CommandType = CommandType.StoredProcedure;
            sqlcmd.CommandText = "GetOpenStockTemplate";
            return data.SelectDataFromDB(sqlcmd);
        }

        public string OpenStockBulkImport(DataTable DtOpenStock,int UserID)
        {
            String Result; bool re;
            Result= data.SQLBulkDataCopy("OpenStockData", DtOpenStock);
            if (Result == "S")
            {
                SqlCommand sqlcmd = new SqlCommand();
                sqlcmd.Parameters.Add("@UserID", SqlDbType.BigInt).Value = UserID;                
                sqlcmd.CommandType = CommandType.StoredProcedure;
                sqlcmd.CommandText = "OpenStockToStockMaster";
                re = data.InsertUpdateDeleteToDB(sqlcmd);
                if (re == false)
                    Result = "Ex";
            }
            return Result;
        }

        public string PurchaseOrdersBulkCopy(DataTable DtPurchaseOrders, int UserID,string Remarks)
        {
            String Result; bool re;
            Result = data.SQLBulkDataCopy("PurchaseOrdersDataTemp", DtPurchaseOrders);
            if (Result == "S")
            {
                SqlCommand sqlcmd = new SqlCommand();
                sqlcmd.Parameters.Add("@UserID", SqlDbType.BigInt).Value = UserID;
                sqlcmd.Parameters.Add("@Remarks", SqlDbType.VarChar,500).Value = Remarks;
                sqlcmd.CommandType = CommandType.StoredProcedure;
                sqlcmd.CommandText = "InsertPurchaseOrdersFromTemptable";
                re = data.InsertUpdateDeleteToDB(sqlcmd);
                if (re == false)
                    Result = "Ex";
            }
            return Result;
        }

        public DataSet PurchaseOrdersLoadData(Byte FilterType, String FilterText)
        {
            SqlCommand sqlcmd = new SqlCommand();
            sqlcmd.CommandType = CommandType.StoredProcedure;
            sqlcmd.Parameters.Add("@FilterType", SqlDbType.TinyInt).Value = FilterType;
            sqlcmd.Parameters.Add("@FilterText", SqlDbType.VarChar, 100).Value = FilterText;
            sqlcmd.CommandText = "PurchaseOrdersLoadData";
            return data.SelectDataFromDB(sqlcmd);
        }

       // Below Data set is for binding the grid of Receipt waiting
        public DataSet LoadPurchaseOrdersDataForReceipts(Byte FilterType, String FilterText)
        {
            SqlCommand sqlcmd = new SqlCommand();
            sqlcmd.CommandType = CommandType.StoredProcedure;
            sqlcmd.Parameters.Add("@FilterType", SqlDbType.TinyInt).Value = FilterType;
            sqlcmd.Parameters.Add("@FilterText", SqlDbType.VarChar, 100).Value = FilterText;
            sqlcmd.CommandText = "LoadPurchaseOrdersDataForReceipts";
            return data.SelectDataFromDB(sqlcmd);
        }

        public DataSet LoadPurchaseOrdersDataForBulkReceipts(Byte FilterType, String FilterText)
        {
            SqlCommand sqlcmd = new SqlCommand();
            sqlcmd.CommandType = CommandType.StoredProcedure;
            sqlcmd.Parameters.Add("@FilterType", SqlDbType.TinyInt).Value = FilterType;
            sqlcmd.Parameters.Add("@FilterText", SqlDbType.VarChar, 100).Value = FilterText;
            sqlcmd.CommandText = "LoadPurchaseOrdersDataForBulkReceipts";
            return data.SelectDataFromDB(sqlcmd);
        }

        //public DataSet LoadPurchaseOrderForReceiptGrid(Byte FilterType, String FilterText)
        //{
        //    SqlCommand sqlcmd = new SqlCommand();
        //    sqlcmd.CommandType = CommandType.StoredProcedure;
        //    sqlcmd.Parameters.Add("@FilterType", SqlDbType.TinyInt).Value = FilterType;
        //    sqlcmd.Parameters.Add("@FilterText", SqlDbType.VarChar, 100).Value = FilterText;
        //    sqlcmd.CommandText = "LoadPurchaseOrderForReceiptGrid";
        //    return data.SelectDataFromDB(sqlcmd);
        //}

       // Single Receipt
        public DataSet GetSinglePurchaseOrderDetailsForReceipt(long PurchaseOrderID)
        {
            SqlCommand sqlcmd = new SqlCommand();
            sqlcmd.CommandType = CommandType.StoredProcedure;
            sqlcmd.CommandText = "GetSinglePurchaseOrderDetailsForReceipt";
            sqlcmd.Parameters.Add("@PurchaseOrderID", SqlDbType.BigInt).Value = PurchaseOrderID;
            return data.SelectDataFromDB(sqlcmd);
        }

        public string PurchaseOrderReceiptBulkCopy(DataTable DtReceipt, int UserID, string Remarks)
        {
            String Result; bool re;
            Result = data.SQLBulkDataCopy("ReceiptDataTemp", DtReceipt);
            if (Result == "S")
            {
                SqlCommand sqlcmd = new SqlCommand();
                sqlcmd.Parameters.Add("@UserID", SqlDbType.Int).Value = UserID;
                sqlcmd.Parameters.Add("@Remarks", SqlDbType.VarChar, 500).Value = Remarks;
                sqlcmd.CommandType = CommandType.StoredProcedure;
                sqlcmd.CommandText = "InsertReceiptFromTemptable";
                re = data.InsertUpdateDeleteToDB(sqlcmd);
                if (re == false)
                    Result = "Ex";
            }
            return Result;
        }

        public string IssueToCustomer(DataTable DtIssue, int UserID, string Remarks,string CustomerName,string ContactNumber,string EmailID,string Others)
        {
            String Result;
            Result = data.SQLBulkDataCopy("IssueToCustomerTemp", DtIssue);
            if (Result == "S")
            {
                SqlCommand sqlcmd = new SqlCommand();
                sqlcmd.Parameters.Add("@UserID", SqlDbType.Int).Value = UserID;
                sqlcmd.Parameters.Add("@Remarks", SqlDbType.VarChar, 500).Value = Remarks;
                sqlcmd.Parameters.Add("@CustomerName", SqlDbType.VarChar, 200).Value = CustomerName;
                sqlcmd.Parameters.Add("@ContactNumber", SqlDbType.VarChar, 200).Value = ContactNumber;
                sqlcmd.Parameters.Add("@EmailID", SqlDbType.VarChar, 200).Value = EmailID;
                sqlcmd.Parameters.Add("@Others", SqlDbType.VarChar, 500).Value = Others;
                sqlcmd.Parameters.Add("@Output", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
                sqlcmd.CommandType = CommandType.StoredProcedure;
                sqlcmd.CommandText = "IssueToCustomer";
                Result = data.InsertUpdateDeleteToDBReturnValue(sqlcmd);
                
            }
            return Result;
        }

        public string GetBarcodeStringAndUpdate(Int64 StockID,int UserID)
        {
            SqlCommand sqlcmd = new SqlCommand();
            sqlcmd.Parameters.Add("@UserID", SqlDbType.Int).Value = UserID;
            sqlcmd.Parameters.Add("@StockID", SqlDbType.BigInt).Value = StockID;
            sqlcmd.Parameters.Add("@Output", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
            sqlcmd.CommandType = CommandType.StoredProcedure;
            sqlcmd.CommandText = "GetBarcodeStringAndUpdate";
            return data.InsertUpdateDeleteToDBReturnValue(sqlcmd);
        }
    }
}
