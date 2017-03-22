import jenkins.model.*
import hudson.model.*
import hudson.slaves.*
import hudson.plugins.sshslaves.*
import java.util.ArrayList;
import hudson.slaves.EnvironmentVariablesNodeProperty.Entry;

  List<Entry> env = new ArrayList<Entry>();
  EnvironmentVariablesNodeProperty envPro = new EnvironmentVariablesNodeProperty(env);
  Slave slave = new DumbSlave(
                    "container-node","Agent node for Docker containers",
                    "/data/jenkins",
                    "1",
                    Node.Mode.NORMAL,
                    "docker-container-label",
                    new JNLPLauncher(),
                    new RetentionStrategy.Always(),
                    new LinkedList())
  slave.getNodeProperties().add(envPro)
  Jenkins.instance.addNode(slave)

for (aSlave in hudson.model.Hudson.instance.slaves) {
  if (aSlave.name == 'container-node') {
    println("\n\nSecret Key for " + aSlave.name + ":" + aSlave.getComputer().getJnlpMac() + "\n\n");
  }
}
