Shader "Mine/DotProduct"
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
                // half dotp = dot(IN.viewDir, o.Normal);
                half dotp = 1 - dot(IN.viewDir, o.Normal);
                // o.Albedo = float3(dotp, 1, 1);
                o.Albedo = float3(0, dotp, 1);
            }
        ENDCG
    }

    FallBack "Diffuse"
}