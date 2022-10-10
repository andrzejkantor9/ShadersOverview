Shader "Mine/PassesAndBlending/Leaves"
{
    Properties
    {
        _MainTexture ("Main Texture", 2D) = "white" {}
    }

    SubShader
    {
        Tags
        {
            "Queue"="Transparent"
            //"RenderType"="Transparent" 
        }

        CGPROGRAM
        #pragma surface surf Lambert alpha:fade

        sampler2D _MainTexture;

        struct Input
        {
            float2 uv_MainTexture;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 color = tex2D(_MainTexture, IN.uv_MainTexture);

            o.Albedo = color.rgb;
            o.Alpha = color.a;
        }
        ENDCG
    }

    FallBack "Diffuse"
}