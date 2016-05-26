package org.ocaml.ide.highlighter

import com.intellij.lang.annotation.AnnotationHolder
import com.intellij.lang.annotation.ExternalAnnotator
import com.intellij.lang.annotation.HighlightSeverity
import com.intellij.openapi.application.ApplicationManager
import com.intellij.openapi.util.TextRange
import com.intellij.openapi.vfs.VirtualFile
import com.intellij.psi.PsiFile
import org.jetbrains.annotations.NotNull
import org.ocaml.ide.components.MerlinServiceComponent
import org.ocaml.merlin.MerlinError
import org.ocaml.util.LineNumbering

/**
 * Created by sidharthkuruvila on 26/05/16.
 */
class MerlinErrorHighlightingAnnotater : ExternalAnnotator<MerlinInfo, Results>() {

    companion object {
        val merlinErrors = mapOf(
                Pair("type", HighlightSeverity.ERROR),
                Pair("parser", HighlightSeverity.ERROR),
                Pair("env",  HighlightSeverity.ERROR),
                Pair("warning", HighlightSeverity.WARNING),
                Pair("unkown", HighlightSeverity.INFORMATION))
    }

    //TODO Add some inteligence here to help decide wether the annotator should run
    override fun collectInformation(@NotNull file: PsiFile): MerlinInfo? {
        val component = ApplicationManager.getApplication().getComponent(MerlinServiceComponent::class.java)
        val vf = file.virtualFile
        return MerlinInfo(vf, file.text, component)
    }

    override fun doAnnotate(merlinInfo: MerlinInfo): Results? {
        val ln = LineNumbering(merlinInfo.source)
        val errors = merlinInfo.merlinService.errors(merlinInfo.file)
        return Results(errors, ln)
    }

    override fun apply(file: PsiFile, results: Results, holder: AnnotationHolder) {
        val ln = results.lineNumbering
        for(error in results.errors){
            val range = TextRange(ln.index(error.start), ln.index(error.end))
            val severity = merlinErrors[error.type]!!
            val message = error.message
            holder.createAnnotation(severity, range, message)
        }
    }

}

data class MerlinInfo(
        val file: VirtualFile,
        val source: String,
        val merlinService: MerlinServiceComponent)

data class Results(val errors: List<MerlinError>, val lineNumbering: LineNumbering)