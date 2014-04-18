using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using System.Configuration;
using System.Collections.Specialized;
using System.Data.OleDb;

namespace FourMImpexClass.DAL
{
    public class DBExecution
    {
        string sqlserver, database, userid, password;
        public string conStr;
        int cmdtimeout;
        public string BaseURL;

        public DBExecution()
        {

            sqlserver = ConfigurationManager.AppSettings["SqlServer"];
            userid = ConfigurationManager.AppSettings["UserID"];
            password = ConfigurationManager.AppSettings["Password"];
            database = ConfigurationManager.AppSettings["DataBase"];
            cmdtimeout = Convert.ToInt16(ConfigurationManager.AppSettings["SqlCommandTime"]);
            conStr = "Connect Timeout=" + ConfigurationManager.AppSettings["SqlConnectionTime"] + ";pooling='true' ;Max Pool Size=200;Data Source=" + sqlserver + ";Initial Catalog=" + database + ";User ID=" + userid + ";Password=" + password;

        }
        public DataSet SelectDataFromDB(SqlCommand sqlcmd)
        {
            SqlConnection con = new SqlConnection(conStr);
            sqlcmd.Connection = con;
            sqlcmd.CommandTimeout = cmdtimeout;
            SqlDataAdapter sda = new SqlDataAdapter(sqlcmd);
            DataSet ds = new DataSet();
            try
            {
                con.Open();
                sda.Fill(ds);
                con.Close();
            }
            catch(Exception ee)
            {
                // ds.Clear();
            }
            finally
            {
                con.Close();
            }
            return ds;
        }
        public Boolean InsertUpdateDeleteToDB(SqlCommand sqlcmd)
        {

            SqlConnection con = new SqlConnection(conStr);
            sqlcmd.Connection = con;
            sqlcmd.CommandTimeout = cmdtimeout;
            try
            {
                con.Open();
                sqlcmd.ExecuteNonQuery();
                con.Close();
                return true;
            }
            catch
            {
                return false;
            }
            finally
            {
                con.Close();
            }
        }

        public string InsertUpdateDeleteToDBReturnValue(SqlCommand sqlcmd)
        {

            SqlConnection con = new SqlConnection(conStr);
            sqlcmd.Connection = con;
            sqlcmd.CommandTimeout = cmdtimeout;
            try
            {
                con.Open();
                sqlcmd.ExecuteNonQuery();
                con.Close();
                return Convert.ToString(sqlcmd.Parameters["@Output"].Value);
            }
            catch
            {
                return "E";    //E represents Error
            }
            finally
            {
                con.Close();
            }
        }

        public string SQLBulkDataCopy(string TableName,DataTable dt)
        {
            SqlConnection connect=new SqlConnection(conStr);
            connect.Open();
            try
            {            
            SqlTransaction transaction = connect.BeginTransaction();
            SqlBulkCopy BulkData = new SqlBulkCopy(connect,SqlBulkCopyOptions.TableLock,transaction);
            BulkData.DestinationTableName = TableName;
            try
            {
                BulkData.WriteToServer(dt);
                transaction.Commit();
                return "S";
            }
            catch(Exception ex)
            {
                transaction.Rollback();
                return "Er:" + ex.ToString();
            }
            }
            catch (Exception ex)
            {

                connect.Close();
                return "Er" + ex.ToString(); 
            }
           
            
        }

        public string SQLDDLquery(string Query)
        {
            SqlConnection con = new SqlConnection(conStr);

            SqlCommand DDLCmd = new SqlCommand(Query,con); 
            try
            {
                con.Open();
                DDLCmd.ExecuteNonQuery();
                con.Close();
                return "S";
            }
            catch
            {
                // ds.Clear();
                return "E";
            }
            finally
            {
                con.Close();
            }
            
        }
    }
}
