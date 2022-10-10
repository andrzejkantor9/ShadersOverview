Shader "Mine/PassesAndBlending/Hologram"
{
    Properties
    {
        _RimColor ("Rim Color", Color) = (0, 0.5, 0.5, 0)
        _RimPower ("Rim Power", Range(0.5, 8.0)) = 3.0
    }

    SubShader
    {
        Tags
        {
            "Queue" = "Transparent"
        }

        Pass
        {
            ZWrite On
            // ColorMask RGB
            ColorMask 0
        }

        CGPROGRAM
            #pragma surface surf Lambert alpha:fade

            struct Input
            {
                float3 viewDir;
            };

            float4 _RimColor;
            float _RimPower;

            void surf (Input IN, inout SurfaceOutput o)
            {
                half rim = 1 - saturate(dot(normalize(IN.viewDir), o.Normal));
                half rimPower = pow(rim, _RimPower);
                o.Emission = _RimColor.rgb * rimPower * 10;

                o.Alpha = rimPower;
            }
        ENDCG
    }

    FallBack "Diffuse"
}