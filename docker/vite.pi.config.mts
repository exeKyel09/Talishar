// Wraps Talishar-FE's Vite config for docker-compose.pi.yml.
// Vite only accepts localhost and IP addresses as Host by default, so the
// Raspberry Pi's hostname (PI_HOSTNAME) has to be allowed explicitly.
import baseConfig from '/app/vite.config.mts';

export default (env: { mode: string }) => {
  const config = baseConfig(env);
  const hostname = process.env.PI_HOSTNAME;
  if (hostname) {
    config.server = { ...config.server, allowedHosts: [hostname] };
  }
  return config;
};
