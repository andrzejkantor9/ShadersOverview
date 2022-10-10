Shader "Mine/PassesAndBlending/BasicTextureBlend"
{
    Properties
    {
        _MainTexture ("Main Texture", 2D) = "white" {}
        _DecalTexture ("Decal Texture", 2D) = "white" {}
        [Toggle] _ShowDecal("Show Decal?", Float) = 0
    }

    SubShader
    {
        Tags
        {
            "Queue" = "Geometry"
        }

        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _MainTexture;
        sampler2D _DecalTexture;
        float _ShowDecal;

        struct Input
        {
            float2 uv_MainTexture;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 a = tex2D(_MainTexture, IN.uv_MainTexture);
            fixed4 b = tex2D(_DecalTexture, IN.uv_MainTexture) * _ShowDecal;

            // o.Albedo = a.rgb * b.rgb;
            // o.Albedo = a.rgb + b.rgb;
            o.Albedo = b.r > 0.9 ?  b.rgb : a.rgb;
        }
        ENDCG
    }

    FallBack "Diffuse"
}