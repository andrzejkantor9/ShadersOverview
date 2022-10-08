Shader "Mine/DotProduct/Cutoff"
{

    SubShader
    {
        CGPROGRAM
            #pragma surface surf Lambert

            struct Input
            {
                float3 viewDir;
            };

            void surf (Input IN, inout SurfaceOutput o)
            {
                half rim = 1 - saturate(dot(normalize(IN.viewDir), o.Normal));
                // o.Emission = _RimColor.rgb * rim > 0.17 ? rim : 0;
                // o.Emission = rim > 0.7 ? float3(1,0,0) : 0;
                o.Emission = rim > 0.6 ? float3(1,0,0) : rim > 0.4 ? float3(0,1,0) : 0;
            }
        ENDCG
    }

    FallBack "Diffuse"
}