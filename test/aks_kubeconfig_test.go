package test

import (
	"fmt"
	"io/ioutil"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/client-go/kubernetes"
	"k8s.io/client-go/tools/clientcmd"
)

func TestAKSKubeConfig(t *testing.T) {
	t.Parallel()

	terraformDependenciesOptions := &terraform.Options{
		TerraformDir: "./dependencies",
		VarFiles:     []string{"testing.tfvars"},
	}

	defer terraform.Destroy(t, terraformDependenciesOptions)
	terraform.InitAndApply(t, terraformDependenciesOptions)

	terraformFixtureOptions := &terraform.Options{
		TerraformDir: "./fixture",
		VarFiles:     []string{"testing.tfvars"},
	}

	defer terraform.Destroy(t, terraformFixtureOptions)
	terraform.InitAndApply(t, terraformFixtureOptions)

	aksKubeConfig := terraform.Output(t, terraformFixtureOptions, "aks_kube_config")

	err := testKubeConfig(aksKubeConfig)
	if err != nil {
		t.Fatalf("AKS KubeConfig test has failed: %e", err)
	}
}

func testKubeConfig(aksKubeConfig string) error {
	// get a bytes array with the AKS kube config
	kubeconfigBytes := []byte(aksKubeConfig)

	// write a temporary file with kube config
	err := ioutil.WriteFile("/tmp/kubeconfig", kubeconfigBytes, 0644)
	if err != nil {
		return err
	}

	// create config from file
	config, err := clientcmd.BuildConfigFromFlags("", "/tmp/kubeconfig")
	if err != nil {
		return err
	}

	// create a new Kubernetes client using the config
	client, err := kubernetes.NewForConfig(config)
	if err != nil {
		return err
	}

	// retrieve the list of nodes
	nodesList, err := client.CoreV1().Nodes().List(metav1.ListOptions{})
	if err != nil {
		return err
	}

	// check there are two nodes
	expectedNodesCount := 2
	actualNodesCount := len(nodesList.Items)
	if actualNodesCount != expectedNodesCount {
		return fmt.Errorf("Expected nodes count = %d, Actual = %d", expectedNodesCount, actualNodesCount)
	}

	return nil
}
