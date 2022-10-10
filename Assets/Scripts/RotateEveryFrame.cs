using UnityEngine;

public class RotateEveryFrame : MonoBehaviour
{
    ////////////////////////////////////////////////////////////////////////////////////////////////

    #region EngineMethods & Contructors
    private void Update() 
    {
        transform.Rotate(0, 50 * Time.deltaTime, 0);
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
