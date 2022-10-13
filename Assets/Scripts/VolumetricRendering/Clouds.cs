using UnityEngine;

[ExecuteInEditMode]
public class Clouds : MonoBehaviour
{
    #region Config
    [Header("CONFIG")]
    [SerializeField]
    private float _minHeight = 0f;
    [SerializeField]
    private float _maxHeight = 5f;
    [SerializeField]
    private float _fadeDistance = 2f;
    [SerializeField]
    private float _scale = 5f;
    [SerializeField]
    private float _steps = 50;
    #endregion

    #region Cache
    [Header("CACHE")]
	[Space(8f)]
    [SerializeField]
    private Shader _cloudShader;
    [SerializeField]
    private Texture _valueNoiseImage;
    [SerializeField]
    private Transform _sunTransform;
    
    private Material _material;
    private Camera _camera;
    #endregion

    #region States
    #endregion

    #region Events & Statics
    #endregion

    #region Data
    #endregion

    ////////////////////////////////////////////////////////////////////////////////////////////////

    #region EngineMethods & Contructors
    private void Start()
    {
        if(_material)
            DestroyImmediate(_material);
    }

    private void OnDisable() 
    {
        if(_material)
            DestroyImmediate(_material);
    }
    #endregion

    #region PublicMethods
    public Material Material
    {
        get
        {
            if(_material == null && _cloudShader != null)
            {
                _material = new Material(_cloudShader);
            }
            if(_material != null && _cloudShader == null)
            {
                DestroyImmediate(_material);
            }
            if(_material != null && _cloudShader != null && _cloudShader != _material.shader)
            {
                DestroyImmediate(_material);
                _material = new Material(_cloudShader);
            }

            return _material;
        }
    }
    #endregion

    #region Interfaces & Inheritance
    #endregion

    #region Events & Statics
    #endregion

    #region PrivateMethods
    private Matrix4x4 GetFrustumCorners()
    {
        Matrix4x4 frustumCorners = Matrix4x4.identity;
        Vector3[] fCorners = new Vector3[4];

        _camera.CalculateFrustumCorners
            (new Rect(0, 0, 1, 1), _camera.farClipPlane, Camera.MonoOrStereoscopicEye.Mono, fCorners);

        frustumCorners.SetRow(0, Vector3.Scale(fCorners[1], new Vector3(1, 1, -1)));
        frustumCorners.SetRow(1, Vector3.Scale(fCorners[2], new Vector3(1, 1, -1)));
        frustumCorners.SetRow(2, Vector3.Scale(fCorners[3], new Vector3(1, 1, -1)));
        frustumCorners.SetRow(3, Vector3.Scale(fCorners[0], new Vector3(1, 1, -1)));

        return frustumCorners;
    }
    //_Steps material set float

    [ImageEffectOpaque]
    void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        if (Material == null || _valueNoiseImage == null)
        {
            Graphics.Blit(source, destination);
            return;
        }

        if (_camera == null)
            _camera = GetComponent<Camera>();

        Material.SetTexture("_ValueNoise", _valueNoiseImage);
        if (_sunTransform != null)
            Material.SetVector("_SunDir", -_sunTransform.forward);
        else
            Material.SetVector("_SunDir", Vector3.up);

        Material.SetFloat("_MinHeight", _minHeight);
        Material.SetFloat("_MaxHeight", _maxHeight);
        Material.SetFloat("_FadeDist", _fadeDistance);
        Material.SetFloat("_Scale", _scale);
        Material.SetFloat("_Steps", _steps);

        Material.SetMatrix("_FrustumCornersWS", GetFrustumCorners());
        Material.SetMatrix("_CameraInvViewMatrix", _camera.cameraToWorldMatrix);
        Material.SetVector("_CameraPosWS", _camera.transform.position);

        CustomGraphicsBlit(source, destination, Material, 0);

    }

    //"drawin clouds to screen"
    static void CustomGraphicsBlit(RenderTexture source, RenderTexture destination, Material fxMaterial, int passNr)
    {
        RenderTexture.active = destination;

        fxMaterial.SetTexture("_MainTex", source);

        GL.PushMatrix();
        GL.LoadOrtho();

        fxMaterial.SetPass(passNr);

        GL.Begin(GL.QUADS);

        GL.MultiTexCoord2(0, 0f, 0f);
        GL.Vertex3(0f, 0f, 3f); //BL

        GL.MultiTexCoord2(0, 1f, 0f);
        GL.Vertex3(1f, 0f, 2f); //BR

        GL.MultiTexCoord2(0, 1f, 1f);
        GL.Vertex3(1f, 1f, 1f); //TR

        GL.MultiTexCoord2(0, 0f, 1f);
        GL.Vertex3(0f, 1f, 0f); //TL

        GL.End();
        GL.PopMatrix();
    }
    #endregion
}
