// +build !windows

package cli

const (
	defaultBindAddress      = ":8888"
	defaultDataDirectory    = "gen/data"
	defaultAssetsDirectory  = "./"
	defaultNoAuth           = "false"
	defaultNoAnalytics      = "false"
	defaultTLS              = "false"
	defaultTLSSkipVerify    = "false"
	defaultTLSCACertPath    = "gen/certs/ca.pem"
	defaultTLSCertPath      = "gen/certs/cert.pem"
	defaultTLSKeyPath       = "gen/certs/key.pem"
	defaultSSL              = "false"
	defaultSSLCertPath      = "gen/certs/portainer.crt"
	defaultSSLKeyPath       = "gen/certs/portainer.key"
	defaultSyncInterval     = "60s"
	defaultSnapshot         = "true"
	defaultSnapshotInterval = "5m"
	defaultTemplateFile     = "templates.json"
)
