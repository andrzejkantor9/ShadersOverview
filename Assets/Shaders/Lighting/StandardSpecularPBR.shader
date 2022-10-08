Shader "Mine/Lighting/StandardSpecularPBR"
{
    Properties
    {
        _Color("Color", Color) = (1, 1, 1, 1)
        _MetallicTex ("Metallic (R)", 2D) = "white" {}
        _SpecularColor ("Specular", Color) = (1, 1, 1, 1)
    }

    SubShader
    {
        Tags
        {
            "Queue" = "Geometry"
        }

        CGPROGRAM
        #pragma surface surf StandardSpecular

        sampler2D _MetallicTex;
        //_SpecColor already exixsts in unity
        fixed4 _SpecularColor;
        fixed4 _Color;

        struct Input
        {
            float2 uv_MetallicTex;
        };

        void surf (Input IN, inout SurfaceOutputStandardSpecular o)
        {
            o.Albedo = _Color.rgb;
            o.Smoothness = tex2D (_MetallicTex, IN.uv_MetallicTex).r;
            o.Specular = _SpecularColor.rgb;
        }
        ENDCG
    }

    FallBack "Diffuse"
}