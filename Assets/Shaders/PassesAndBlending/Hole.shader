Shader "Mine/PassesAndBlending/Hole"
{
    Properties
    {
        _MainTexture ("Main Texture", 2D) = "white" {}
    }

    SubShader
    {
        Tags
        {
            "Queue" = "Geometry-1"
        }

        ColorMask 0
        ZWrite Off
        
        Stencil
        {
            Ref 1
            Comp always
            Pass replace
        }

        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _MainTexture;

        struct Input
        {
            float2 uv_MainTexture;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 color = tex2D(_MainTexture, IN.uv_MainTexture);

            o.Albedo = color.rgb;
        }
        ENDCG
    }

    FallBack "Diffuse"
}