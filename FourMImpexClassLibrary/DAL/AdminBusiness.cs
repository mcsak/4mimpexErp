using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Security;

namespace FourMImpexClass.DAL
{
   public class AdminBusiness
    {

       DBExecution data = new DBExecution();


       public string CreatePasswordHash(string pwd, string salt)
       {
           string saltAndPwd = null;
           string hashedPwd = null;
           saltAndPwd = pwd;
           hashedPwd = FormsAuthentication.HashPasswordForStoringInConfigFile(saltAndPwd, "SHA1");
           return hashedPwd;
       }

       public DataSet GetUserandPass(string UserID, string Password)
       {
           SqlCommand sqlcmd = new SqlCommand();
           sqlcmd.Parameters.Add("@UserID", SqlDbType.VarChar, 50).Value = UserID;
           sqlcmd.Parameters.Add("@Password", SqlDbType.VarChar, 50).Value = Password;
           sqlcmd.CommandType = CommandType.StoredProcedure;
           sqlcmd.CommandText = "GetUserandPass";
           return data.SelectDataFromDB(sqlcmd);
       }



       //User Login 
       public DataSet userverify(string uemail, string upassword)
       {
           SqlCommand sqlcmd = new SqlCommand();
           sqlcmd.CommandType = CommandType.StoredProcedure;
           sqlcmd.Parameters.Add(new SqlParameter("@username", SqlDbType.VarChar, 50));
           sqlcmd.Parameters.Add(new SqlParameter("@password", SqlDbType.VarChar, 50));
           sqlcmd.Parameters["@username"].Value = uemail;
           sqlcmd.Parameters["@password"].Value = upassword;
           sqlcmd.CommandType = CommandType.StoredProcedure;
           sqlcmd.CommandText = "UserAndPasswdVerify";
           return data.SelectDataFromDB(sqlcmd);
       }

       //Product Add/Modify/Delete      
       public DataSet IUDProduct( Int64 ProductID, string Product,string ProductDescription,Int64 UserID,int Action)
       {
           SqlCommand sqlcmd = new SqlCommand();
           sqlcmd.Parameters.Add("@ProductID", SqlDbType.BigInt).Value = ProductID;
           sqlcmd.Parameters.Add("@Product", SqlDbType.VarChar, 100).Value = Product;
           sqlcmd.Parameters.Add("@ProductDescription", SqlDbType.VarChar, 500).Value = ProductDescription;
           sqlcmd.Parameters.Add("@UserID", SqlDbType.BigInt).Value = UserID;
           sqlcmd.Parameters.Add("@Action", SqlDbType.Int).Value = Action;
           sqlcmd.CommandType = CommandType.StoredProcedure;
           sqlcmd.CommandText = "IUDProduct";
           return data.SelectDataFromDB(sqlcmd);
       }

       //Brand Add/Modify/Delete      
       public DataSet IUDBrand(Int64 ProductID,Int64 BrandID,string Brand,string BrandDescription,Int64 UserID,int Action)
       {
           SqlCommand sqlcmd = new SqlCommand();
           sqlcmd.Parameters.Add("@ProductID",SqlDbType.BigInt).Value=ProductID;
           sqlcmd.Parameters.Add("@BrandID", SqlDbType.BigInt).Value = BrandID;
           sqlcmd.Parameters.Add("@Brand", SqlDbType.VarChar, 100).Value = Brand;
           sqlcmd.Parameters.Add("@BrandDescription", SqlDbType.VarChar, 500).Value = BrandDescription;
           sqlcmd.Parameters.Add("@UserID", SqlDbType.BigInt).Value = UserID;
           sqlcmd.Parameters.Add("@Action", SqlDbType.Int).Value = Action;
           sqlcmd.CommandType = CommandType.StoredProcedure;
           sqlcmd.CommandText = "IUDBrand";
           return data.SelectDataFromDB(sqlcmd);
       }

        //Brand Add/Modify/Delete      
       public DataSet IUDModel(Int64 ProductID, Int64 BrandID,Int64 ModelID, string Model,string ModelDescription,Int64 UserID,int Action)
       {
           SqlCommand sqlcmd = new SqlCommand();
           sqlcmd.Parameters.Add("@ProductID",SqlDbType.BigInt).Value=ProductID;
           sqlcmd.Parameters.Add("@BrandID", SqlDbType.BigInt).Value = BrandID;
           sqlcmd.Parameters.Add("@ModelID", SqlDbType.BigInt).Value = ModelID;
           sqlcmd.Parameters.Add("@Model", SqlDbType.VarChar, 100).Value = Model;
           sqlcmd.Parameters.Add("@ModelDescription", SqlDbType.VarChar, 500).Value = ModelDescription;
           sqlcmd.Parameters.Add("@UserID", SqlDbType.BigInt).Value = UserID;
           sqlcmd.Parameters.Add("@Action", SqlDbType.Int).Value = Action;
           sqlcmd.CommandType = CommandType.StoredProcedure;
           sqlcmd.CommandText = "IUDModel";
           return data.SelectDataFromDB(sqlcmd);
       }

       //Price Add/Modify/Delete      
       public DataSet IUDPrice(Int64 ProductID, Int64 BrandID, Int64 ModelID,Int64 PriceID, string Price, string Description,byte Discount, Int64 UserID, int Action)
       {
           SqlCommand sqlcmd = new SqlCommand();
           sqlcmd.Parameters.Add("@ProductID", SqlDbType.BigInt).Value = ProductID;
           sqlcmd.Parameters.Add("@BrandID", SqlDbType.BigInt).Value = BrandID;
           sqlcmd.Parameters.Add("@ModelID", SqlDbType.BigInt).Value = ModelID;
           sqlcmd.Parameters.Add("@PriceID", SqlDbType.BigInt).Value = PriceID;
           sqlcmd.Parameters.Add("@Price", SqlDbType.VarChar, 100).Value = Price;
           sqlcmd.Parameters.Add("@Description", SqlDbType.VarChar, 500).Value = Description;
           sqlcmd.Parameters.Add("@Discount", SqlDbType.TinyInt, 500).Value = Discount;
           sqlcmd.Parameters.Add("@UserID", SqlDbType.BigInt).Value = UserID;
           sqlcmd.Parameters.Add("@Action", SqlDbType.Int).Value = Action;
           sqlcmd.CommandType = CommandType.StoredProcedure;
           sqlcmd.CommandText = "IUDPrice";
           return data.SelectDataFromDB(sqlcmd);
       }
         
       //Product Grid

       public DataSet GetProduct(string searchtext, int flag)
       {
           SqlCommand sqlcmd = new SqlCommand();
           sqlcmd.Parameters.Add(new SqlParameter("@SearchText", SqlDbType.VarChar, 50));
           sqlcmd.Parameters.Add(new SqlParameter("@Flag", SqlDbType.Int));
           sqlcmd.Parameters["@SearchText"].Value = searchtext;
           sqlcmd.Parameters["@Flag"].Value = flag;
           sqlcmd.CommandType = CommandType.StoredProcedure;
           sqlcmd.CommandText = "GetProduct";
           return data.SelectDataFromDB(sqlcmd);
       }

       //Get Product in Add/Modify/Delete

       public DataSet BindProduct(Int64 ProductID)
       {
           SqlCommand sqlcmd = new SqlCommand();
           sqlcmd.Parameters.Add("@ProductID", SqlDbType.BigInt).Value = ProductID;
           sqlcmd.CommandType = CommandType.StoredProcedure;
           sqlcmd.CommandText = "BindProduct";
           return data.SelectDataFromDB(sqlcmd);
       }

       //Product Drop Down

       public DataSet BindProductList()
       {
           SqlCommand sqlcmd = new SqlCommand();
           sqlcmd.CommandType = CommandType.StoredProcedure;
           sqlcmd.CommandText = "BindProductList";
           return data.SelectDataFromDB(sqlcmd);
       }

       //Brand Drop Down

       public DataSet BindBrandList(Int64 ProductID)
       {
           SqlCommand sqlcmd = new SqlCommand();
           sqlcmd.Parameters.Add("@ProductID", SqlDbType.BigInt).Value = ProductID;
           sqlcmd.CommandType = CommandType.StoredProcedure;
           sqlcmd.CommandText = "BindBrandList";
           return data.SelectDataFromDB(sqlcmd);
       }

       //Model Drop Down

       public DataSet BindModelList(Int64 BrandID)
       {
           SqlCommand sqlcmd = new SqlCommand();
           sqlcmd.Parameters.Add("@BrandID", SqlDbType.BigInt).Value = BrandID;
           sqlcmd.CommandType = CommandType.StoredProcedure;
           sqlcmd.CommandText = "BindModelList";
           return data.SelectDataFromDB(sqlcmd);
       }

     //Get Brand Details

       public DataSet BindBrand(Int64 BrandID)
       {
           SqlCommand sqlcmd = new SqlCommand();
           sqlcmd.Parameters.Add("@BrandID", SqlDbType.BigInt).Value = BrandID;
           sqlcmd.CommandType = CommandType.StoredProcedure;
           sqlcmd.CommandText = "BindBrand";
           return data.SelectDataFromDB(sqlcmd);
       }

       //Get Model Details

       public DataSet BindModel(Int64 ModelID)
       {
           SqlCommand sqlcmd = new SqlCommand();
           sqlcmd.Parameters.Add("@ModelID", SqlDbType.BigInt).Value = ModelID;
           sqlcmd.CommandType = CommandType.StoredProcedure;
           sqlcmd.CommandText = "BindModel";
           return data.SelectDataFromDB(sqlcmd);
       }

       //Brand Grid

       public DataSet GetBrand(string searchtext, int flag)
       {
           SqlCommand sqlcmd = new SqlCommand();
           sqlcmd.Parameters.Add(new SqlParameter("@SearchText", SqlDbType.VarChar, 50));
           sqlcmd.Parameters.Add(new SqlParameter("@Flag", SqlDbType.Int));
           sqlcmd.Parameters["@SearchText"].Value = searchtext;
           sqlcmd.Parameters["@Flag"].Value = flag;
           sqlcmd.CommandType = CommandType.StoredProcedure;
           sqlcmd.CommandText = "GetBrand";
           return data.SelectDataFromDB(sqlcmd);
       }

       //Model Grid

       public DataSet GridModel(string searchtext, int flag)
       {
           SqlCommand sqlcmd = new SqlCommand();
           sqlcmd.Parameters.Add(new SqlParameter("@SearchText", SqlDbType.VarChar, 50));
           sqlcmd.Parameters.Add(new SqlParameter("@Flag", SqlDbType.Int));
           sqlcmd.Parameters["@SearchText"].Value = searchtext;
           sqlcmd.Parameters["@Flag"].Value = flag;
           sqlcmd.CommandType = CommandType.StoredProcedure;
           sqlcmd.CommandText = "GridModel";
           return data.SelectDataFromDB(sqlcmd);
       }

       //Bind Price


       public DataSet BindPricing(Int64 PriceID)
       {
           SqlCommand sqlcmd = new SqlCommand();
           sqlcmd.Parameters.Add("@PriceID", SqlDbType.BigInt).Value = PriceID;
           sqlcmd.CommandType = CommandType.StoredProcedure;
           sqlcmd.CommandText = "BindPricing";
           return data.SelectDataFromDB(sqlcmd);
       }

       //Price Grid

       public DataSet GridPrice(string searchtext, int flag)
       {
           SqlCommand sqlcmd = new SqlCommand();
           sqlcmd.Parameters.Add(new SqlParameter("@SearchText", SqlDbType.VarChar, 50));
           sqlcmd.Parameters.Add(new SqlParameter("@Flag", SqlDbType.Int));
           sqlcmd.Parameters["@SearchText"].Value = searchtext;
           sqlcmd.Parameters["@Flag"].Value = flag;
           sqlcmd.CommandType = CommandType.StoredProcedure;
           sqlcmd.CommandText = "GridPrice";
           return data.SelectDataFromDB(sqlcmd);
       }

       public string IUDCustomers(string CustomerName,String CustomerContacts,string EmailAddress,String Address)
       {
           SqlCommand sqlcmd = new SqlCommand();
           sqlcmd.Parameters.Add(new SqlParameter("@CustomerName", SqlDbType.VarChar, 100)).Value = CustomerName;
           sqlcmd.Parameters.Add(new SqlParameter("@CustomerContacts", SqlDbType.VarChar, 100)).Value = CustomerContacts;
           sqlcmd.Parameters.Add(new SqlParameter("@EmailAddress", SqlDbType.VarChar, 50)).Value = EmailAddress;
           sqlcmd.Parameters.Add(new SqlParameter("@Address", SqlDbType.VarChar, 250)).Value = Address;
           sqlcmd.Parameters.Add(new SqlParameter("@Output", SqlDbType.VarChar, 250)).Direction = ParameterDirection.Output;  
           sqlcmd.CommandType = CommandType.StoredProcedure;
           sqlcmd.CommandText = "IUDCustomers";
           return data.InsertUpdateDeleteToDBReturnValue(sqlcmd);
       }

    }
}
