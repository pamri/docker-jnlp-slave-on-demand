import jenkins.model.*
import hudson.model.*
import hudson.slaves.*
import hudson.plugins.sshslaves.*
import java.util.ArrayList;
import hudson.slaves.EnvironmentVariablesNodeProperty.Entry;

for (aSlave in hudson.model.Hudson.instance.slaves) {
  if (aSlave.name == 'container-node') {
    hudson.model.Hudson.instance.removeNode(aSlave)
  }
}
