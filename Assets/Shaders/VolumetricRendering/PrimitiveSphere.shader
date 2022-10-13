Shader "Mine/VolumetricRendering/PrimitiveSphere"
{
    SubShader
    {
        Tags { "Queue"="Transparent" }

        Blend SrcAlpha OneMinusSrcAlpha

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            #include "UnityLightingCommon.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                // float3 normal: NORMAL;
            };

            struct v2f
            {
                float3 wPosition : TEXCOORD0;
                float4 position : SV_POSITION;
                // fixed4 diff: COLOR0;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.position = UnityObjectToClipPos(v.vertex);
                o.wPosition = mul(unity_ObjectToWorld, v.vertex).xyz;

                return o;
            }

            #define STEPS 128
            #define STEP_SIZE 0.02

            bool SphereHit(float3 p, float3 centre, float radius)
            {
                return distance (p, centre) < radius;
            }

            float3 RaymarchHit(float3 position, float3 direction)
            {
                for(int i=0; i < STEPS; i++)
                {
                    if(SphereHit(position, float3(0, 0, 0), 0.5))
                        return position;

                    position += direction * STEP_SIZE;
                }

                return float3(0, 0, 0);
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float3 viewDirection = normalize(i.wPosition - _WorldSpaceCameraPos);
                float3 worldPosition = i.wPosition;
                float3 depth = RaymarchHit(worldPosition, viewDirection);

                half3 worldNormal = depth - float3(0, 0, 0);
                half normalToLight = max (0, dot(worldNormal, _WorldSpaceLightPos0.xyz));

                if(length(depth) !=0)
                {
                    depth *= normalToLight * _LightColor0 * 2;
                    return fixed4(depth, 1);
                }
                else
                    return fixed4(1, 1, 1, 0);
            }
            ENDCG
        }
    }
}
