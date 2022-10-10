Shader "Mine/PassesAndBlending/Wall"
{
    Properties
    {
        _MainTexture ("Main Texture", 2D) = "white" {}
    }

    SubShader
    {
        Tags
        {
            "Queue" = "Geometry"
        }

        Stencil
        {
            //if there is 1 in stencil buffer than do not draw this
            Ref 1
            Comp notequal
            Pass keep
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