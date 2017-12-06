<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Menu.ascx.cs" Inherits="SMSWeb.Menu" %>

<asp:Repeater ID="Rpt_Menu" OnItemDataBound="Rpt_Menu_ItemDataBound" runat="server">
    <ItemTemplate>
        <div class="items">
            <div class="item_title" style='<%#Eval("background") %>'>
                <div style="background: url('<%#Eval("ImgUrl") %>'); background-repeat: no-repeat; background-position-x: left; background-position-y:8px; padding-left: 24px;"><%#Eval("MenuTitle") %></div>
                <i class="icon_right">></i>
            </div>
            <div class="list_item" style='<%#Eval("display") %>'>
                <ul>
                    <asp:Repeater ID="Rpt_SubMenu" runat="server">
                        <ItemTemplate>
                            <li>
                            <a style='<%#Eval("background") %>' href="<%#Eval("MenuUrl") %>"><%#Eval("MenuTitle") %></a>
                        </li>
                        </ItemTemplate>
                        
                    </asp:Repeater>

                    
                </ul>
            </div>
        </div>
    </ItemTemplate>


</asp:Repeater>


