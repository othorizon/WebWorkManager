using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MinRegister : System.Web.UI.Page
{
    static DBBean db;
    static bool userexist;

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            userexist = false;
            db = new DBBean();
            ddl_type.SelectedIndex = 0;
   
           //清除登陆状态
            HttpCookie cookie = Request.Cookies["UserStatus"];
            if (cookie != null)
            {
                cookie.Expires = DateTime.Now;
                Response.Cookies.Add(cookie);
            }
          // td_username.Visible = td_pwd1.Visible = td_pwd2.Visible = td_nextbutton.Visible = false;
        }

    }

    protected void ddl_type_SelectedIndexChanged(object sender, EventArgs e)
    {
      //  td_username.Visible = td_pwd1.Visible = td_pwd2.Visible = td_nextbutton.Visible = true;
     //   Page.ClientScript.RegisterStartupScript(GetType(), "", "test()", true);
        Page.ClientScript.RegisterStartupScript(GetType(), "", "show1()", true);
       
        if (ddl_type.SelectedIndex != 0)
            if (ddl_type.Items.Count == 3)
            {
                td_username.Visible = td_pwd1.Visible = td_pwd2.Visible = td_nextbutton.Visible = true;
                ddl_type.Items.RemoveAt(0);

            }
         
        if (ddl_type.SelectedValue.ToString() == "teacher")
            lb_name.Text = "职工编号:";
        if (ddl_type.SelectedValue.ToString() == "student")
            lb_name.Text = "学号:";
    
    }

    protected void bt_next_Click(object sender, EventArgs e)
    {

      //  Page.ClientScript.RegisterStartupScript(GetType(), "", "alert('asd');", true);

        if (userexist)
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "", "show1()", true);
            return;
        }

        if (step1())//注册第一步
        {
            tb_username.Enabled = ddl_type.Enabled = false;
          //  Page.ClientScript.RegisterStartupScript(GetType(), "", "hide()", true);

            if (ddl_type.SelectedValue.Equals("student"))
            {
                if (stepstudent())
                {
                    tb_stepstudent.Visible = true;
                    tb_pwd1.Visible = tb_pwd2.Visible = bt_next.Visible = false;
                    Page.ClientScript.RegisterStartupScript(GetType(), "", "showstudent()", true);
                   
                }
            }
            if (ddl_type.SelectedValue.Equals("teacher"))
            {
                if (stepteacher())
                {
                    tb_stepteacher.Visible = true;
                    tb_pwd1.Visible = tb_pwd2.Visible = bt_next.Visible = false;
                    Page.ClientScript.RegisterStartupScript(GetType(), "", "showteacher()", true);
 
                }
            }

        }
        
    }

    private bool stepteacher()
    {
        DBBean db2 = new DBBean();
        string sql = "select ClassID,Name from ClassInfo";
        DataTable dt = db2.GetDataTable(sql);
        if (dt != null)
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                listb_Class.Items.Add(new ListItem(dt.Rows[i]["Name"].ToString(), dt.Rows[i]["ClassID"].ToString()));
            }
            return true;
        }
        else
            return false;

    }
    private bool step1()
    {

        bool ret = true; ;
        string sql = "insert into UserInfo (UserID,PassWord,Type) values('" +
     tb_username.Text.Trim() + "','" + tb_pwd1.Text + "','" + ddl_type.SelectedValue.ToString() + "');";
        db.open();
        db.BeginTrans();
        try
        {
            int result = db.ExecuteNonQueryWithTran(sql);
            if (result < 1)
            {
                db.Rollback();
                Page.ClientScript.RegisterClientScriptBlock(GetType(), "wrong", "alert('注册失败')", true);
                ret = false;
            }


        }
        catch (Exception ex)
        {
            db.Rollback();
            Page.ClientScript.RegisterClientScriptBlock(GetType(), "wrong", "alert('" + ex.ToString() + "')", true);
            ret = false;
        }

        return ret;
    }
    protected void bt_Finish_Click(object sender, EventArgs e)
    {
        if (insertStudent())
        {
          //  db.Commit();
          //  Page.ClientScript.RegisterClientScriptBlock(GetType(), "", "alert('注册成功')", true);
            Page.ClientScript.RegisterStartupScript(GetType(), "", "returnstudent()", true);

        }

    }

    protected void bt_Finish2_Click(object sender, EventArgs e)
    {
        if (insertTeacher())
        {
           // db.Commit();
           // Page.ClientScript.RegisterClientScriptBlock(GetType(), "", "alert('注册成功')", true);
            Page.ClientScript.RegisterStartupScript(GetType(), "", "returnteacher()", true);
        }
    }

    private bool insertTeacher()
    {
        ArrayList sqls = new ArrayList();
        string sql1 = "insert into TeacherInfo (TeacherID,Name,ClassID) values('" +
            tb_username.Text.Trim() + "','" + tb_name2.Text.Trim() + "','";

        for (int i = 0; i < listb_Class.Items.Count; i++)
        {
            if (listb_Class.Items[i].Selected)
            {
                string sql2 = sql1 + listb_Class.Items[i].Value.ToString() + "')";
                sqls.Add(sql2);

            }
        }
        if (executesqls(sqls))
            return true;
        else
            return false;

     

    }

    private bool executesqls(ArrayList sqls)
    {
        bool ret=true;
        try
        {
            for (int i = 0; i < sqls.Count; i++)
            {
                int result = db.ExecuteNonQueryWithTran(sqls[i].ToString());
                if (result < 1)
                {
                    db.Rollback();
                    Page.ClientScript.RegisterClientScriptBlock(GetType(), "wrong", "alert('注册失败')", true);
                    ret = false;
                    break;
                }
            }
        }
        catch (Exception ex)
        {
            db.Rollback();
            Page.ClientScript.RegisterClientScriptBlock(GetType(), "wrong", "alert('" + ex.ToString() + "')", true);
            ret = false;
        }
        return ret;
    }
    private bool insertStudent()
    {
        string sql = "insert into StudentInfo (StudentID,Name,ClassID) values('" +
            tb_username.Text.Trim() + "','" + tb_name.Text.Trim() + "','" + ddl_class.SelectedValue.ToString() + "')";
        bool ret = true;
        try
        {
            int result = db.ExecuteNonQueryWithTran(sql);
            if (result < 1)
            {
                db.Rollback();
                Page.ClientScript.RegisterClientScriptBlock(GetType(), "wrong", "alert('注册失败')", true);
                ret = false;
            }

        }
        catch (Exception ex)
        {
            db.Rollback();
            Page.ClientScript.RegisterClientScriptBlock(GetType(), "wrong", "alert('" + ex.ToString() + "')", true);
            ret = false;
        }
        return ret;


    }
    private bool stepstudent()
    {
        DBBean db2 = new DBBean();
        string sql = "select ClassID,Name from ClassInfo";
        DataTable dt = db2.GetDataTable(sql);
        if (dt != null)
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                ddl_class.Items.Add(new ListItem(dt.Rows[i]["Name"].ToString(), dt.Rows[i]["ClassID"].ToString()));
            }
            return true;
        }
        else
            return false;

    }


    protected void tb_username_TextChanged(object sender, EventArgs e)
    {
   //     System.Threading.Thread.Sleep(5000);
        if (tb_username.Text.Trim().Equals(""))
        {
            lb_checkname.Text = "";
            return;
        }

        string sql = "select UserID from UserInfo where UserID='" + tb_username.Text.Trim() + "'";
        if (db.GetDataRow(sql) != null)
        {
            userexist = true;
            lb_checkname.Text = "已存在";
            lb_checkname.ForeColor = System.Drawing.Color.Red;
        }
        else
        {
            userexist = false;
            lb_checkname.Text = "可以使用";
            lb_checkname.ForeColor = System.Drawing.Color.Green;
        }
    }


}