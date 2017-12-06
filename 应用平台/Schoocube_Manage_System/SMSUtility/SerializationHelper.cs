using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Reflection;
using System.Text;
using System.Xml.Serialization;

namespace SMSUtility
{
    /// <summary>
    /// ���л�
    /// </summary>
    public class SerializationHelper
    {
        #region �Զ���汾��
        #region ��ʱ���л��뷴���л�����

        /// <summary>
        /// �����л�
        /// </summary>
        /// <param name="type">��������</param>
        /// <param name="filename">�ļ�·��</param>
        /// <returns></returns>
        public static object Load(Type type, string filename)
        {
            FileStream fs = null;
            try
            {
                // open the stream...
                fs = new FileStream(filename, FileMode.Open, FileAccess.Read, FileShare.ReadWrite);
                var serializer = new XmlSerializer(type);
                return serializer.Deserialize(fs);
            }
            finally
            {
                if (fs != null)
                    fs.Close();
            }
        }


        /// <summary>
        /// ���л�
        /// </summary>
        /// <param name="obj">����</param>
        /// <param name="filename">�ļ�·��</param>
        public static void Save(object obj, string filename)
        {
            FileStream fs = null;
            // serialize it...
            try
            {
                fs = new FileStream(filename, FileMode.Create, FileAccess.Write, FileShare.ReadWrite);
                var serializer = new XmlSerializer(obj.GetType());
                serializer.Serialize(fs, obj);
            }
            finally
            {
                if (fs != null)
                    fs.Close();
            }
        }

        #endregion

        #region DataTableת����Json

        //DataTableת��Json
        /// <summary>
        /// Ϊdatatable�ṩ����
        /// </summary>
        /// <param name="jsonName">json����</param>
        /// <param name="dt">������</param>
        /// <returns></returns>
        public static string DataTableToJson(string jsonName, DataTable dt)
        {
            var json = new StringBuilder();
            json.Append("{ \"total\":" + dt.Rows.Count + ",\"" + jsonName + "\":[");
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    json.Append("{");
                    for (int j = 0; j < dt.Columns.Count; j++)
                    {
                        json.Append("\"" + dt.Columns[j].ColumnName + "\":\"" + dt.Rows[i][j] + "\"");
                        if (j < dt.Columns.Count - 1)
                        {
                            json.Append(",");
                        }
                    }
                    json.Append("}");
                    if (i < dt.Rows.Count - 1)
                    {
                        json.Append(",");
                    }
                }
            }
            json.Append("]}");
            return json.ToString();
        }
        //
        /// <summary>
        /// DataTableת��Json
        /// </summary>
        /// <param name="dt">��</param>
        /// <returns></returns>
        public static string DataTableToJson(DataTable dt)
        {
            var json = new StringBuilder();
            json.Append("[");
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    json.Append("{");
                    for (int j = 0; j < dt.Columns.Count; j++)
                    {
                        json.Append("\"" + dt.Columns[j].ColumnName + "\":\"" + dt.Rows[i][j] + "\"");
                        if (j < dt.Columns.Count - 1)
                        {
                            json.Append(",");
                        }
                    }
                    json.Append("}");
                    if (i < dt.Rows.Count - 1)
                    {
                        json.Append(",");
                    }
                }
            }
            json.Append("]");
            return json.ToString();
        }
        #endregion

        #region List<>ת��json
        /// <summary>
        /// List<>ת��json
        /// </summary>
        /// <typeparam name="T">����</typeparam>
        /// <param name="jsonName">json����</param>
        /// <param name="il">����</param>
        /// <returns></returns>
        public static string ObjectToJson<T>(string jsonName, IList<T> il)
        {
            var json = new StringBuilder();
            json.Append("{\"" + jsonName + "\":[");
            if (il.Count > 0)
            {
                for (int i = 0; i < il.Count; i++)
                {
                    var obj = Activator.CreateInstance<T>();
                    Type type = obj.GetType();
                    PropertyInfo[] pis = type.GetProperties();
                    json.Append("{");
                    for (int j = 0; j < pis.Length; j++)
                    {
                        json.Append("\"" + pis[j].Name + "\":\"" + pis[j].GetValue(il[i], null) + "\"");
                        if (j < pis.Length - 1)
                        {
                            json.Append(",");
                        }
                    }
                    json.Append("}");
                    if (i < il.Count - 1)
                    {
                        json.Append(",");
                    }
                }
            }
            json.Append("]}");
            return json.ToString();
        }

        #endregion
        #endregion
    }
}