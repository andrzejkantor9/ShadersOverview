using UnityEngine;

public class MeshData : MonoBehaviour
{
    ////////////////////////////////////////////////////////////////////////////////////////////////

    #region EngineMethods & Contructors
    private void Start() 
    {
        Mesh mesh = GetComponent<MeshFilter>().mesh;
        Vector3[] vertices = mesh.vertices;

        foreach(Vector3 vertex in vertices)
        {
            Debug.Log(vertex);
        }
    }
    #endregion

    #region PublicMethods
    #endregion

    #region Interfaces & Inheritance
    #endregion

    #region Events & Statics
    #endregion

    #region PrivateMethods
    #endregion
}
