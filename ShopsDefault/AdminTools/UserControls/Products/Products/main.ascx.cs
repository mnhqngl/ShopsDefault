using Librari;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ShopsDefault.AdminTools.UserControls.Products.Products
{
    public partial class main : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                this.BindData();
            }
        }

        protected void Page_Init(object sender, EventArgs e)
        {
            ds.ConnectionString = Librari.AccessDB.sConn;
            ds.SelectCommand = "st_tbShopsCatalogs_SelectAll_Active";
            ds.SelectCommandType = SqlDataSourceCommandType.StoredProcedure;
        }

        private void BindData()
        {
            grv.DataSource = Cls_ShopsProducts.getDataTableJoinShopsCatalogs("tbShopsProducts.ID_Catalog = tbShopsCatalogs.ID_Catalog");
            grv.DataBind();
        }

        protected void grv_OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.TableSection = TableRowSection.TableHeader;
            }
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string getName = e.Row.Cells[1].Text;
                LinkButton lnk = (LinkButton)e.Row.FindControl("lnkDelete");
                lnk.Attributes.Add("onclick", "return confirm('Bạn có muốn xóa Xe " + getName + " không?')");
            }
        }

        protected void grv_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grv.PageIndex = e.NewPageIndex;
            BindData();
        }

        protected void RefreshText()
        {
            txtID_Catalog.SelectedValue = "0";
            txtProductName.Text = "";
            txtProductCode.Text = "";
            txtPriceOut.Text = "";
            txtTitleWeb.Text = "";
            txtColor.Text = "";
            txtAmount.Text = "";
            txtWeight.Text = "";
            txtSummaryContent.Text = "";
            txtDetail.Text = "";
            txtImage.Text = "";
            txtLinkSEO.Text = "";
            cbHidden.Checked = false;
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            btnSave.Text = "Lưu";
            RefreshText();
            popup.Show();
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            btnSave.Text = "Cập nhật";
            GridViewRow row = (GridViewRow)((LinkButton)sender).Parent.Parent;
            var ID_find = Convert.ToInt32(row.Cells[0].Text);
            Cls_ShopsProducts cls = Cls_ShopsProducts.getOject_Key_Not_Date(ID_find);
            txtID_Product.Text = ID_find.ToString();
            txtID_Catalog.SelectedValue = cls.ID_Catalog.ToString();
            txtProductName.Text = cls.ProductName.ToString();
            txtProductCode.Text = cls.ProductCode.ToString();
            txtPriceOut.Text = cls.PriceOut.ToString();
            txtColor.Text = cls.Color.ToString();
            txtAmount.Text = cls.Amount.ToString();
            txtWeight.Text = cls.Weight.ToString();
            txtSummaryContent.Text = cls.SummaryContent.ToString();
            txtTitleWeb.Text = cls.TitleWeb.ToString();
            txtImage.Text = cls.Image.ToString();
            txtDetail.Text = cls.Description.ToString();
            txtLinkSEO.Text = cls.LinkSEO.ToString();
            cbHidden.Checked = cls.Hidden;

            popup.Show();
        }

        protected void grv_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int ID = Convert.ToInt32(grv.DataKeys[e.RowIndex].Values[0]);
            Cls_ShopsProducts cls = new Cls_ShopsProducts();
            cls.ID_Product_find = ID;

            if (cls.doDelete() == 1)
            {
                string sMessages = "alert('Đã xóa thành công');";
                ScriptManager.RegisterStartupScript(UpdatePanel1, UpdatePanel1.GetType(), "", sMessages, true);
            }
            else
            {
                string sMessages = "alert('Đã xảy ra lỗi trong quá trình xóa dữ liệu');";
                ScriptManager.RegisterStartupScript(UpdatePanel1, UpdatePanel1.GetType(), "", sMessages, true);
            }
            BindData();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (fuImage.HasFile)
            {
                string selectedCategory = txtID_Catalog.SelectedItem.Text.ToLower().Replace(" ", "-");
                if (!string.IsNullOrEmpty(selectedCategory) && selectedCategory != "chọn-nhóm-xe")
                {
                    try
                    {
                        string filename = Path.GetFileName(fuImage.FileName);
                        string folderPath = Server.MapPath("~/images/UploadImages/san-pham/" + selectedCategory + "/");

                        // Tạo thư mục nếu chưa tồn tại
                        if (!Directory.Exists(folderPath))
                        {
                            Directory.CreateDirectory(folderPath);
                        }

                        // Lưu tệp vào thư mục
                        string filePath = folderPath + filename;
                        fuImage.SaveAs(filePath);

                        // Cập nhật đường dẫn hình ảnh
                        txtImage.Text = "/images/UploadImages/san-pham/" + selectedCategory + "/" + filename;
                    }
                    catch (Exception ex)
                    {
                        string sMessages = "alert('Đã xảy ra lỗi trong quá trình tải tệp: " + ex.Message + "');";
                        ScriptManager.RegisterStartupScript(UpdatePanel1, UpdatePanel1.GetType(), "", sMessages, true);
                        return;
                    }
                }
                else
                {
                    string sMessages = "alert('Vui lòng chọn nhóm Xe hợp lệ.');";
                    ScriptManager.RegisterStartupScript(UpdatePanel1, UpdatePanel1.GetType(), "", sMessages, true);
                    return;
                }
            }

            Cls_ShopsProducts cls = new Cls_ShopsProducts
            {
                ID_Catalog = Convert.ToInt32(txtID_Catalog.SelectedValue),
                ProductName = txtProductName.Text.Trim(),
                ProductCode = txtProductCode.Text.Trim(),
                Image = txtImage.Text.Trim(),
                PriceOut = !string.IsNullOrEmpty(txtPriceOut.Text.Trim()) ? Convert.ToDouble(txtPriceOut.Text.Trim()) : 0,
                Color = txtColor.Text.Trim(),
                Amount = !string.IsNullOrEmpty(txtAmount.Text.Trim()) ? Convert.ToInt32(txtAmount.Text.Trim()) : 0,
                Weight = !string.IsNullOrEmpty(txtWeight.Text.Trim()) ? Convert.ToDouble(txtWeight.Text.Trim()) : 0,
                SummaryContent = txtSummaryContent.Text.Trim(),
                Description = txtDetail.Text.Trim(),
                TitleWeb = txtTitleWeb.Text.Trim(),
                LinkSEO = txtLinkSEO.Text.Trim(),
                H1SEO = txtProductName.Text.Trim(),
                KeywordSEO = txtProductName.Text.Trim(),
                EditTime = DateTime.Now,
                Hidden = cbHidden.Checked
            };

            if (btnSave.Text == "Lưu")
            {
                cls.AddTime = DateTime.Now;

                if (cls.doInsert() == 1)
                {
                    string sMessages = "alert('Đã thêm dữ liệu thành công!');";
                    ScriptManager.RegisterStartupScript(UpdatePanel1, UpdatePanel1.GetType(), "", sMessages, true);
                }
                else
                {
                    string sMessages = "alert('Đã xảy ra lỗi trong quá trình thêm dữ liệu! Bạn vui lòng kiểm tra lại!');";
                    ScriptManager.RegisterStartupScript(UpdatePanel1, UpdatePanel1.GetType(), "", sMessages, true);
                }
            }
            else if (btnSave.Text == "Cập nhật")
            {
                cls.ID_Product_find = Convert.ToInt32(txtID_Product.Text.Trim());

                if (cls.doUpdate() == 1)
                {
                    string sMessages = "alert('Đã chỉnh sửa dữ liệu thành công!');";
                    ScriptManager.RegisterStartupScript(UpdatePanel1, UpdatePanel1.GetType(), "", sMessages, true);
                }
                else
                {
                    string sMessages = "alert('Đã xảy ra lỗi trong quá trình chỉnh sửa dữ liệu! Bạn vui lòng kiểm tra lại!');";
                    ScriptManager.RegisterStartupScript(UpdatePanel1, UpdatePanel1.GetType(), "", sMessages, true);
                }
            }
            BindData();
        }
    }
}
