Shader "Mine/DotProduct/CutoffWithDiffuse"
{
    Properties
    {
        _MainTex ("Base (RGB)", 2D) = "white" {}
        _StripeWidth ("StripeWidth", Range(1, 20)) = 10
    }

    SubShader
    {
        CGPROGRAM
            #pragma surface surf Lambert

            sampler2D _MainTex;
            float _StripeWidth;

            struct Input
            {
                float2 uv_MainTex;

                float3 viewDir;
                float3 worldPos;
            };

            void surf (Input IN, inout SurfaceOutput o)
            {
                o.Albedo = (tex2D(_MainTex, IN.uv_MainTex)).rgb;
                half rim = 1 - saturate(dot(normalize(IN.viewDir), o.Normal));

                // // o.Emission = IN.worldPos.y > 1 ? float3(0,1,0) : float3(1,0,0);
                // o.Emission = (frac(IN.worldPos.y * 10 * 0.5) > 0.4 ? 
                //     float3(0, 1, 0) * rim : float3(1, 0, 0) * rim) * _StripeWidth;
                o.Emission = frac(IN.worldPos.y*(20-_StripeWidth) * 0.5) > 0.4 ? 
                    float3(0,1,0)*rim: float3(1,0,0)*rim;
            }
        ENDCG
    }

    FallBack "Diffuse"
}